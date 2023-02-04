RSpec.describe Mutations::CreateTag, type: :graphql do
  let(:mutation_string) do
    <<~GQL
      mutation($input: CreateTagInput!) {
        createTag(input: $input) {
          tag {
            slug
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
        slug:      Faker::Internet.domain_word,
        name:      Faker::Lorem.sentence,
      }
    end

    subject do
      execute_graphql(mutation_string, context: { current_user: user }, variables: { input: input })
    end

    it "should create a new tag" do
      expect { subject }.to change { Tag.count }.by(1)
      expect(subject["errors"]).to be_nil
      expect(subject["data"]["createTag"]["tag"]).not_to be_nil
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
