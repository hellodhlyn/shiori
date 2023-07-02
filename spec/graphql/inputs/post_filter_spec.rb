RSpec.describe Types::Inputs::PostFilter, type: :graphql do
  let(:namespace) { create :namespace }
  let(:tags) { create_list :tag, 3, namespace: namespace }
  let(:posts) do
    [
      create(:post, namespace: namespace, tags: [tags[0], tags[1]]),
      create(:post, namespace: namespace, tags: [tags[1], tags[2]]),
      create(:post),
    ]
  end

  describe "#apply" do
    subject { described_class.new(nil, ruby_kwargs: args, context: nil, defaults_used: nil).apply(Post.all) }

    context "tags" do
      let(:args) { { tags: [tags[1].slug] }}

      it "should return the posts with the given tags" do
        expect(subject).to match_array [posts[0], posts[1]]
      end
    end

    context "namespace" do
      let(:args) { { site: namespace.site.slug, namespace: namespace.slug } }

      it "should return the posts with the given namespace" do
        expect(subject).to match_array posts.select { |p| p.namespace == namespace }
      end
    end
  end
end
