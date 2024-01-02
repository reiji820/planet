FactoryBot.define do
  factory :time_schedule do
    time_stamp { "Sat, 01 Jan 2000 00:00:00.000000000 JST +09:00" }
    plan { "海遊館に行く" }
    association :post
  end
end