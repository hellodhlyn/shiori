FactoryBot.define do
  factory :blob do
    post { create :post }

    trait :markdown do
      content { { "text" => Faker::Lorem.paragraph } }
    end

    trait :plaintext do
      content { { "text" => Faker::Lorem.paragraph } }
    end

    factory :markdown_blob,  class: "Blobs::Markdown",  traits: [:markdown]
    factory :plaintext_blob, class: "Blobs::Plaintext", traits: [:plaintext]
  end
end
