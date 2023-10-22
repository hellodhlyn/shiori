FactoryBot.define do
  factory :site do
    name { Faker::Internet.domain_name }
    slug { Faker::Internet.slug }
  end
end
