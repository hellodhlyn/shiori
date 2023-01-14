FactoryBot.define do
  factory :user do
    name         { Faker::Internet.username }
    display_name { Faker::Name.name }
  end
end
