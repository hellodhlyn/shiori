FactoryBot.define do
  factory :tag do
    namespace { create :namespace }
    name { Faker::Lorem.word }
    slug { Faker::Lorem.word }
  end
end
