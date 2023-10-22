RSpec.describe Types::FeaturedContentType, type: :graphql do
  let(:query_string) do
    <<~GQL
      query {
        featuredContents {
          title
          slug
          description
          posts(first: 3) {
            nodes {
              title
            }
          }
        }
      }
    GQL
  end

  let(:featured_content) { create(:featured_content) }

  describe "#posts" do
    before do
      featured_content.update(posts: create_list(:post, 5))
      create_list(:post, 5)
    end

    subject do
      execute_graphql(query_string)
    end

    it "should return all featured posts" do
      expect(subject["errors"]).to be_nil
      expect(subject["data"]["featuredContents"].length).to eq 1
      expect(subject["data"]["featuredContents"][0]["posts"]["nodes"].length).to eq 3
      expect(subject["data"]["featuredContents"][0]["posts"]["nodes"].map { _1["title"] })
        .to match_array(featured_content.posts.first(3).map(&:title))
    end
  end
end
