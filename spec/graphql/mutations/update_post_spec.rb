RSpec.describe Mutations::UpdatePost, type: :graphql do
  let(:mutation_string) do
    <<~GQL
      mutation($input: UpdatePostInput!) {
        updatePost(input: $input) {
          post {
            uuid
          }
        }
      }
    GQL
  end

  let(:user) { create :user }
  let(:post_attr) {
    {
      title:       Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      visibility:  Post::Visibilities::PRIVATE,
    }
  }
  let(:post) { create :post, author: user, **post_attr }

  context "valid request" do
    let(:input) do
      {
        id:          post.to_sgid.to_s,
        title:       Faker::Lorem.sentence,
        description: Faker::Lorem.paragraph,
        visibility:  Post::Visibilities::PUBLIC,
      }
    end

    subject do
      execute_graphql(mutation_string, context: { current_user: user }, variables: { input: input })
    end

    it "should update the post" do
      expect { subject }
        .to change { post.reload.title }.from(post_attr[:title]).to(input[:title])
       .and change { post.reload.description }.from(post_attr[:description]).to(input[:description])
       .and change { post.reload.visibility }.from(post_attr[:visibility]).to(input[:visibility])
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
