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
  let(:original_tags) { 3.times.map { create :tag, namespace: post.namespace } }

  before do
    post.update!(tags: original_tags)
  end

  context "valid request" do
    let(:tags) { original_tags.sample(1) + 2.times.map { create :tag, namespace: post.namespace } }
    let(:input) do
      {
        id:          post.to_sgid.to_s,
        title:       Faker::Lorem.sentence,
        description: Faker::Lorem.paragraph,
        visibility:  Post::Visibilities::PUBLIC,
        tags:        tags.map(&:slug),
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

      expect(post.tags.map(&:slug)).to match_array input[:tags]
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

  context "request for another user's post" do
    let(:other_user) { create :user }
    let(:post) { create :post, author: other_user, **post_attr }

    subject do
      execute_graphql(mutation_string, context: { current_user: user }, variables: { input: {} })
    end

    it "should return an error" do
      expect(subject["errors"]).not_to be_nil
    end
  end
end
