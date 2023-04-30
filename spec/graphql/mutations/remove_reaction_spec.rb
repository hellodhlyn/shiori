RSpec.describe Mutations::RemoveReaction, type: :graphql do
  let(:mutation_string) do
    <<~GQL
      mutation($input: RemoveReactionInput!) {
        removeReaction(input: $input) {
          reaction {
            content
            post {
              uuid
            }
          }
        }
      }
    GQL
  end

  let(:user) { create :user }
  let(:post) { create :post }

  subject do
    execute_graphql(mutation_string, context: { current_user: user }, variables: { input: input })
  end

  context "valid request" do
    let(:input) do
      {
        postId:  post.to_sgid.to_s,
        content: Reaction::LIKE,
      }
    end

    shared_examples "should return results" do
      it do
        expect { subject }.to change { Reaction.count }.by(-1)
        expect(subject["errors"]).to be_nil
        expect(subject["data"]["removeReaction"]["reaction"]["content"]).to eq input[:content]
        expect(subject["data"]["removeReaction"]["reaction"]["post"]["uuid"]).to eq post.uuid
      end
    end

    context "reaction exists" do
      before do
        create(:reaction, post: post, user: user, content: input[:content])
      end

      it_behaves_like "should return results"
    end

    context "other reactions exist" do
      before do
        create(:reaction, post: post, user: user, content: input[:content])
        create(:reaction, user: user, post: post, content: Reaction::DISLIKE)
      end

      it_behaves_like "should return results"
    end

    context "reaction not exists" do
      it "should not remove reaction" do
        expect { subject }.not_to change { Reaction.count }
      end
    end
  end

  context "post not exists" do
    let(:input) do
      {
        postId:  SecureRandom.uuid,
        content: Reaction::LIKE,
      }
    end

    it "throws an error" do
      expect(subject["errors"]).not_to be_nil
    end
  end
end
