FactoryBot.define do
  factory :site do
    name { Faker::Internet.domain_name }
    slug { Faker::Internet.domain_word }
  end
end
