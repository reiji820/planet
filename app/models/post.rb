class Post < ApplicationRecord
  belongs_to :user
  has_many :time_schedules, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorites_by_users, through: :favorites, source: :user
  accepts_nested_attributes_for :time_schedules

  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: { maximum: 230 }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :budget, presence: true, length: { maximum: 30 }
  validates :prefecture_id, presence: { message: 'を選択してください' }

  enum season: { 春: 1, 夏: 2, 秋: 3, 冬: 4 }

  attribute :image, :string, default: 'linkedin_banner_image_1.png'

  SEASONS = %w[春 夏 秋 冬].freeze

  def self.search_with_filters(keyword, prefecture_id, season, genre, time_range)
    posts = search(keyword)
    posts = posts.where(prefecture_id: prefecture_id) if prefecture_id.present?
    posts = posts.where(season: season) if season.present?

    posts = posts.joins(:time_schedules).where(time_schedules: { genre: genre }).distinct if genre.present?

    if time_range.present?
      start_time, end_time = time_range.split('-').map(&:to_i)
      if start_time.present? && end_time.blank?
        # 開始時間のみ指定された場合の処理
        start_time_stamp = Time.zone.now.beginning_of_day + start_time.hours
        posts = posts.joins(:time_schedules).where('time_schedules.time_stamp >= ?', start_time_stamp)
      elsif start_time.blank? && end_time.present?
        # 終了時間のみ指定された場合の処理
        end_time_stamp = Time.zone.now.beginning_of_day + end_time.hours
        posts = posts.joins(:time_schedules).where('time_schedules.time_stamp <= ?', end_time_stamp)
      elsif start_time.present? && end_time.present?
        # 開始時間と終了時間の両方が指定された場合の処理
        start_time_stamp = Time.zone.now.beginning_of_day + start_time.hours
        end_time_stamp = Time.zone.now.beginning_of_day + end_time.hours
        posts = posts.joins(:time_schedules).where('time_schedules.time_stamp >= ? AND time_schedules.time_stamp <= ?',
                                                   start_time_stamp, end_time_stamp)
      end
      posts = posts.distinct
    end

    posts
  end

  def self.search(search)
    if search.blank?
      Post.includes(:user).order('created_at DESC')
    else
      Post.where(['title LIKE ?', "%#{search}%"])
    end
  end

  def favorited?(user)
    favorites.exists?(user_id: user.id)
  end
end
