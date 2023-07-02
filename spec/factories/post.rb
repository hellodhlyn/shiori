FactoryBot.define do
  factory :post do
    namespace { create :namespace }
    title { Faker::Lorem.sentence }
    slug { Faker::Internet.domain_word }
    description { Faker::Lorem.paragraph }
    author { create :user }
    visibility { Post::Visibilities::PUBLIC }
    tags { [] }
  end
end
