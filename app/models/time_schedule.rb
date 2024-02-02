class TimeSchedule < ApplicationRecord
  belongs_to :post

  GENRES = %w[ランチ ディナー カフェ アクティビティ 観光 ショッピング その他].freeze

  validates :time_stamp, presence: true
  validates :plan, presence: true
  validates :genre, inclusion: { in: GENRES }, presence: true

  geocoded_by :address
  after_validation :geocode, if: ->(obj) { obj.address.present? and obj.address_changed? }
end
