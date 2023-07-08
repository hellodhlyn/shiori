require "spec_helper"

RSpec.describe Resolvers::SiteResolver do
  subject { described_class.new(object: nil, context: nil, field: nil) }

  let(:site) { create :site }

  describe "#resolve" do
    context "with a valid slug" do
      it "returns the site" do
        expect(subject.resolve(slug: site.slug)).to eq site
      end
    end

    context "with an invalid slug" do
      it "returns nil" do
        expect(subject.resolve(slug: SecureRandom.uuid)).to be_nil
      end
    end
  end
end
