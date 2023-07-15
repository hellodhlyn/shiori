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
  let(:post) { create(:post, author: user, **post_attr) }
  let(:original_tags)  { create_list(:tag, 3, namespace: post.namespace) }
  let(:original_blobs) { build_list(:plaintext_blob, 3, post: post) }

  before do
    post.update!(tags: original_tags, blobs: original_blobs)
  end

  context "give input fields of post" do
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

  context "give blobs" do
    let(:new_blobs) { [original_blobs[0], build(:plaintext_blob, post: post), original_blobs[2]] }
    let(:input) do
      {
        id:    post.to_sgid.to_s,
        blobs: new_blobs.map do |blob|
          {
            id: blob.id.present? ? blob.to_sgid.to_s : nil,
            type: "plaintext",
            plaintext: { text: blob.text },
          }.compact
        end,
      }
    end

    subject do
      execute_graphql(mutation_string, context: { current_user: user }, variables: { input: input })
    end

    it "should update the blobs" do
      expect { subject }
        .to change { post.reload.blobs.map(&:content) }.from(original_blobs.map(&:content)).to(new_blobs.map(&:content))
        .and not_change { post.reload.title }
        .and not_change { post.reload.description }
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
