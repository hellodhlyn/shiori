FactoryBot.define do
  factory :namespace do
    site
    name { Faker::Internet.domain_name }
    slug { Faker::Internet.domain_word }
  end
end
