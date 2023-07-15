RSpec.describe Queries::PostQuery do
  subject { described_class.new(object: nil, context: context, field: nil) }

  let(:post) { create :post }
  let(:args) { {} }
  let(:context) { {} }

  describe "#resolve" do
    shared_examples "returns the post" do
      it { expect(subject.resolve(**args)).to eq post }
    end

    shared_examples "returns nil" do
      it { expect(subject.resolve(**args)).to be_nil }
    end

    context "with a valid uuid" do
      let(:args) { { uuid: post.uuid } }
      it_behaves_like "returns the post"
    end

    context "with a valid site, namespace, and slug" do
      let(:args) do
        {
          site: post.namespace.site.slug,
          namespace: post.namespace.slug,
          slug: post.slug
        }
      end
      it_behaves_like "returns the post"
    end

    context "with an invalid uuid" do
      let(:args) { { uuid: SecureRandom.uuid } }
      it_behaves_like "returns nil"
    end

    context "with invalid site, namespace, or slug" do
      %i(site namespace slug).each do |key|
        let(:args) do
          {
            site: post.namespace.site.slug,
            namespace: post.namespace.slug,
            slug: post.slug
          }.merge({ key => SecureRandom.uuid })
        end
        it_behaves_like "returns nil"
      end
    end

    context "with a private post" do
      before { post.update!(visibility: Post::Visibilities::PRIVATE) }
      let(:args) { { uuid: post.uuid } }
      it_behaves_like "returns nil"
    end

    context "with a private post and an authorized user" do
      before { post.update!(visibility: Post::Visibilities::PRIVATE) }
      let(:context) { { current_user: post.author } }
      let(:args) { { uuid: post.uuid } }
      it_behaves_like "returns the post"
    end
  end
end
