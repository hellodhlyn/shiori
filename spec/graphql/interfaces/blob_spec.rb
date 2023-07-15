RSpec.describe Types::Interfaces::Blob, type: :graphql do
  let(:post) { create(:post) }
  let(:query_string) do
    <<~GQL
      query($uuid: String!) {
        post(uuid: $uuid) {
          uuid
          title
          description
          thumbnailUrl
          createdAt
          blobs {
            ... on MarkdownBlob { text }
            ... on PlaintextBlob { text }
            ... on ImageBlob { url previewUrl blurhash caption }
          }
        }
      }
    GQL
  end

  before do
    create(:markdown_blob, post: post, text: Faker::Lorem.paragraph)
    create(:plaintext_blob, post: post, text: Faker::Lorem.paragraph)
  end

  subject do
    execute_graphql(query_string, variables: { uuid: post.uuid })
  end

  it "should return the post" do
    expect(subject["errors"]).to be_nil
    expect(subject["data"]["post"]["uuid"]).to eq post.uuid
  end
end
