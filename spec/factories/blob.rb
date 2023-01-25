FactoryBot.define do
  factory :blob do
    post { create :post }
    content { Faker::Lorem.paragraph }
  end
end
