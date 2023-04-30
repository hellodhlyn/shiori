RSpec.describe ReactionSummary do
  let(:post) { create :post }
  let(:viewer) { create :user }

  before do
    create(:reaction, post: post, content: Reaction::LIKE)
    create(:reaction, post: post, content: Reaction::LIKE, user: viewer)
    create_list(:reaction, 3, post: post, content: Reaction::DISLIKE)
  end

  describe "counts" do
   subject { described_class.new(post.reactions) }

    it do
      expect(subject.total_count).to eq 5
      expect(subject.count_by_content).to eq [
        { content: Reaction::LIKE,    count: 2 },
        { content: Reaction::DISLIKE, count: 3 }
      ]
      expect(subject.viewer_reactions).to eq []
    end
  end

  describe "viewer's reactions" do
    subject { described_class.new(post.reactions, viewer: viewer) }

    it do
      expect(subject.viewer_reactions).to be_present
      expect(subject.viewer_reactions).to eq post.reactions.where(user: viewer)
    end
  end
end
