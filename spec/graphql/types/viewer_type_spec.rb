RSpec.describe Types::ViewerType, type: :graphql do
  let(:query_string) do
    <<~GQL
      query {
        viewer {
          name
          posts {
            edges {
              node {
                uuid
              }
            }
          }
        }
      }
    GQL
  end

  let(:user) { create :user }
  let!(:public_post) { create :post, author: user, visibility: Post::Visibilities::PUBLIC }
  let!(:private_post) { create :post, author: user, visibility: Post::Visibilities::PRIVATE }

  context "valid request" do
    subject do
      execute_graphql(query_string, context: { current_user: user })
    end

    it "should return the current user" do
      expect(subject["errors"]).to be_nil
      expect(subject["data"]["viewer"]["name"]).to eq user.name
    end

    it "should return the current user's posts" do
      expect(subject["errors"]).to be_nil
      expect(subject["data"]["viewer"]["posts"]["edges"].map { |edge| edge["node"]["uuid"] })
        .to include private_post.uuid
    end
  end
end
