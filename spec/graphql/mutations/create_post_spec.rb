RSpec.describe Mutations::CreatePost, type: :graphql do
  let(:mutation_string) do
    <<~GQL
      mutation($input: CreatePostInput!) {
        createPost(input: $input) {
          post {
            uuid
            blobs { type content }
          }
        }
      }
    GQL
  end

  let(:user) { create :user }
  let(:namespace) { create :namespace }

  context "valid request" do
    let(:input) do
      {
        site:      namespace.site.slug,
        namespace: namespace.slug,
        title:     Faker::Lorem.sentence,
        slug:      Faker::Internet.domain_word,
        blobs:     (0..2).map { |index| { type: "markdown", content: index.to_s } },
      }
    end

    subject do
      execute_graphql(mutation_string, context: { current_user: user }, variables: { input: input })
    end

    it "should create a new post" do
      expect(subject["error"]).to be_nil
      expect(subject["data"]["createPost"]["post"]).not_to be_nil
    end

    it "should create blobs with the correct indices" do
      expect(subject["error"]).to be_nil
      expect(subject["data"]["createPost"]["post"]["blobs"].map { |blob| blob["content"].to_i }).to eq [0, 1, 2]
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
end
