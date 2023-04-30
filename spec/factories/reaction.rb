FactoryBot.define do
  factory :reaction do
    user { create :user }
    post { create :post }
    content { Reaction::LIKE }
  end
end
