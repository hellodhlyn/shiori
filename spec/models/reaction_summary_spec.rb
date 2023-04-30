RSpec.describe ReactionSummary do
  let(:post) { create :post }

  before do
    create_list(:reaction, 2, post: post, content: Reaction::LIKE)
    create_list(:reaction, 3, post: post, content: Reaction::DISLIKE)
  end

  subject { described_class.new(post.reactions) }

  it do
    expect(subject.total_count).to eq 5
    expect(subject.count_by_content).to eq [
      { content: Reaction::LIKE,    count: 2 },
      { content: Reaction::DISLIKE, count: 3 }
    ]
  end
end
