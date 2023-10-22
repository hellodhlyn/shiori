FactoryBot.define do
  factory :namespace do
    site
    name { Faker::Internet.domain_name }
    slug { Faker::Lorem.word }
  end
end
