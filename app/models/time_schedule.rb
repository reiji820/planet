class TimeSchedule < ApplicationRecord
  belongs_to :post

  GENRES = %w[ランチ ディナー カフェ アクティビティ 観光 ショッピング その他].freeze

  validates :time_stamp, presence: true
  validates :plan, presence: true
  validates :genre, inclusion: { in: GENRES }, presence: true
end
