FactoryBot.define do
  factory :tag do
    namespace { create :namespace }
    name { Faker::Lorem.word }
    slug { Faker::Internet.slug }
  end
end
