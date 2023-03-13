FactoryBot.define do
  factory :blob, class: "Blobs::Markdown" do
    post { create :post }
    content { { "text" => Faker::Lorem.paragraph } }
  end
end
