require "spec_helper"

RSpec.describe Queries::FeaturedContentsQuery do
  subject { described_class.new(object: nil, context: nil, field: nil) }

  let(:args) { {} }

  before { create_list :featured_content, 3 }

  describe "#resolve" do
    context "without any arguments" do
      it "returns all featured contents" do
        expect(subject.resolve).to eq(FeaturedContent.all)
      end
    end

    context "with slugs" do
      let(:args) { { slugs: FeaturedContent.first(2).map(&:slug) } }

      it do
        expect(subject.resolve(**args)).to eq(FeaturedContent.first(2))
      end
    end
  end
end
