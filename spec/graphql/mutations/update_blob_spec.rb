RSpec.describe Mutations::UpdateBlob, type: :graphql do
  let(:mutation_string) do
    <<~GQL
      mutation($input: UpdateBlobInput!) {
        updateBlob(input: $input) {
          blob {
            uuid
          }
        }
      }
    GQL
  end

  let(:user) { create :user }
  let(:post) { create :post, author: user }
  let(:content) {
    {
      text: Faker::Lorem.paragraph,
    }
  }
  let(:blob) { create :blob, post: post, content: content }

  context "valid request" do
    let(:input) do
      {
        id:      blob.to_sgid.to_s,
        blob: {
          type: "markdown",
          markdown: {
            text: Faker::Lorem.paragraph,
          },
        },
      }
    end

    subject do
      execute_graphql(mutation_string, context: { current_user: user }, variables: { input: input })
    end

    it "should update the blob" do
      expect { subject }
        .to change { blob.reload.text }.from(content[:text]).to(input[:blob][:markdown][:text])
    end
  end

  context "unauthorized request" do
    subject do
      execute_graphql(mutation_string, context: { current_user: nil }, variables: { input: {} })
    end

    it "should return an error" do
      expect(subject["errors"]).not_to be_nil
    end
  end

  context "request for another user's blob" do
    let(:other_user) { create :user }
    let(:blob) { create :blob, author: other_user, **blob_attr }

    subject do
      execute_graphql(mutation_string, context: { current_user: user }, variables: { input: {} })
    end

    it "should return an error" do
      expect(subject["errors"]).not_to be_nil
    end
  end
end