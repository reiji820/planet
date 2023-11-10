class TimeSchedule < ApplicationRecord
  belongs_to :post

  validates :time_stamp, presence: true
  validates :plan, presence: true
end
