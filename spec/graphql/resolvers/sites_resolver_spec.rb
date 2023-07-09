require "spec_helper"

RSpec.describe Resolvers::SitesResolver do
  subject { described_class.new(object: nil, context: nil, field: nil) }

  before { create_list :site, 3 }

  describe "#resolve" do
    it "returns all sites" do
      expect(subject.resolve).to eq Site.all
    end
  end
end
