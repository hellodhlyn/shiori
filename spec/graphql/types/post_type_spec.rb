RSpec.describe Types::PostType, type: :graphql do
  let(:query_string) do
    <<~GQL
      query($postUuid: String!) {
        post(uuid: $postUuid) {
          reactionSummary {
            totalCount
            countByContent {
              content count
            }
          }
          featuredContents {
            title
          }
        }
      }
    GQL
  end

  let(:post) { create(:post) }

  describe "#reaction_summary" do
    before do
      create_list(:reaction, 2, post: post, content: Reaction::LIKE)
      create_list(:reaction, 3, post: post, content: Reaction::DISLIKE)
    end

    subject do
      execute_graphql(query_string, variables: { postUuid: post.uuid })
    end

    it "should return the correct reaction summary" do
      expect(subject["errors"]).to be_nil
      expect(subject["data"]["post"]["reactionSummary"]["totalCount"]).to eq 5
      expect(subject["data"]["post"]["reactionSummary"]["countByContent"]).to eq [
        { "content" => Reaction::LIKE, "count" => 2 },
        { "content" => Reaction::DISLIKE, "count" => 3 },
      ]
    end
  end

  describe "#featured_contents" do
    before do
      create_list(:featured_content, 3, posts: [post])
    end

    subject do
      execute_graphql(query_string, variables: { postUuid: post.uuid })
    end

    it "should return featured content groups" do
      expect(subject["errors"]).to be_nil
      expect(subject["data"]["post"]["featuredContents"].length).to eq(3)
    end
  end
end
