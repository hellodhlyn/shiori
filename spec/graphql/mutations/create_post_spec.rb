RSpec.describe Mutations::CreatePost, type: :graphql do
  let(:mutation_string) do
    <<~GQL
      mutation($input: CreatePostInput!) {
        createPost(input: $input) {
          post { uuid title }
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
        blobs:     [
          {
            type:    "markdown",
            content: Faker::Lorem.paragraph,
          },
        ],
      }
    end

    it "should create a new post" do
      result = execute_graphql(
        mutation_string,
        context: { current_user: user },
        variables: { input: input },
      )
      expect(result["error"]).to be_nil
      expect(result["data"]["createPost"]["post"]).not_to be_nil
    end
  end
end
