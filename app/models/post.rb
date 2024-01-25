class Post < ApplicationRecord
  belongs_to :user
  has_many :time_schedules, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorites_by_users, through: :favorites, source: :user

  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: { maximum: 230 }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :budget, presence: true, length: { maximum: 30 }
  validates :prefecture_id, presence: { message: 'を選択してください' }

  enum season: { 春: 1, 夏: 2, 秋: 3, 冬: 4 }

  attribute :image, :string, default: 'linkedin_banner_image_1.png'

  SEASONS = %w[春 夏 秋 冬].freeze

  def self.search_with_filters(keyword, prefecture_id, season)
    posts = search(keyword)
    posts = posts.where(prefecture_id: prefecture_id) if prefecture_id.present?
    posts = posts.where(season: season) if season.present?
    posts
  end

  def self.search(search)
    if search == ''
      Post.includes(:user).order('created_at DESC')
    else
      Post.where(['title LIKE(?)', "%#{search}%"])
    end
  end

  def favorited?(user)
    favorites.exists?(user_id: user.id)
  end
end
