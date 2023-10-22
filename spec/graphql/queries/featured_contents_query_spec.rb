require "spec_helper"

RSpec.describe Queries::FeaturedContentsQuery do
  subject { described_class.new(object: nil, context: nil, field: nil) }

  before { create_list :featured_content, 3 }

  describe "#resolve" do
    it "returns all featured contents" do
      expect(subject.resolve).to eq FeaturedContent.all
    end
  end
end
