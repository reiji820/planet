FactoryBot.define do
  factory :post do
    sequence(:title, "title_1")
    start_time { "Sat, 01 Jan 2000 00:00:00.000000000 JST +09:00" }
    end_time { "Sat, 01 Jan 2000 12:00:00.000000000 JST +09:00" }
    budget { "budget" }
    image { nil }
    prefecture_id { 1 }
    season { "春" }
    association :user
  end
end