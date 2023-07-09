RSpec.describe Resolvers::ViewerResolver do
  subject { described_class.new(object: nil, context: context, field: nil) }

  let(:viewer) { create :user }

  describe "#resolve" do
    context "unauthorized" do
      let(:context) { {} }
      it "raises an error" do
        expect { subject.resolve }.to raise_error GraphQL::ExecutionError
      end
    end

    context "authorized" do
      let(:context) { { current_user: viewer } }
      it "returns the viewer" do
        expect(subject.resolve).to eq viewer
      end
    end
  end
end
