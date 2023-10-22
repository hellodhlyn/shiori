FactoryBot.define do
  factory :site do
    name { Faker::Internet.domain_name }
    slug { Faker::Lorem.word }
  end
end
