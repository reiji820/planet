class Post < ApplicationRecord
  belongs_to :user
  has_many :time_schedules, dependent: :destroy

  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :budget, presence: true
  validates :image, presence: true

  enum season: { 春:1, 夏:2, 秋:3, 冬:4 }

  def self.search(search)
    if search != ""
      Post.where(['title LIKE(?)', "%#{search}%"])
    else
      Post.includes(:user).order('created_at DESC')
    end
  end
end
