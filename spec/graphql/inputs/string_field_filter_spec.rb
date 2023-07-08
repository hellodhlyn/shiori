RSpec.describe Types::Inputs::StringFieldFilter, type: :graphql do
  let(:namespace) { create :namespace }
  let(:posts) do
    [
      create(:post, namespace: namespace, title: Faker::Lorem.sentence(random_words_to_add: 4)),
      create(:post, namespace: namespace, title: Faker::Lorem.sentence(random_words_to_add: 4)),
      create(:post, namespace: namespace, title: Faker::Lorem.sentence(random_words_to_add: 4)),
    ]
  end

  describe "#apply" do
    subject { described_class.new(nil, ruby_kwargs: args, context: nil, defaults_used: nil).apply(Post.all, :title) }

    shared_examples "should return matching results" do
      it { expect(subject).to match_array [posts[0]] }
    end

    context "equal" do
      let(:args) { { equal: posts[0].title } }
      it_behaves_like "should return matching results"
    end

    context "start_with" do
      let(:args) { { start_with: posts[0].title.split(" ").first } }
      it_behaves_like "should return matching results"
    end

    context "contain" do
      let(:args) { { contain: posts[0].title.split(" ").second } }
      it_behaves_like "should return matching results"
    end
  end
end
