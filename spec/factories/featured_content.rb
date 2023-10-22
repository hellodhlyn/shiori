FactoryBot.define do
  factory :featured_content do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    slug { Faker::Internet.slug }
    posts { [] }
  end
end
