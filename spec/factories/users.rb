FactoryBot.define do
  factory :user do
    sequence(:name, 'user_1')
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    residence { "residence" }
    hobbies { "hobbies" }
    self_introduction { "self_introduction" }
  end
end