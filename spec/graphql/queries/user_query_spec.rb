require "spec_helper"

RSpec.describe Queries::UserQuery do
  subject { described_class.new(object: nil, context: nil, field: nil) }

  let(:user) { create :user }

  describe "#resolve" do
    context "with a valid name" do
      it "returns the user" do
        expect(subject.resolve(name: user.name)).to eq user
      end
    end

    context "with an invalid name" do
      it "returns nil" do
        expect(subject.resolve(name: SecureRandom.uuid)).to be_nil
      end
    end
  end
end
