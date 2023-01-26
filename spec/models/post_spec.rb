RSpec.describe Post, type: :model do
  describe "#visible?" do
    let(:user) { create(:user) }
    let(:post) { create(:post, author: user) }

    it "returns true if the post is public" do
      expect(post.visible?(user)).to eq true
    end

    it "returns true if the post is private and the user is the author" do
      post.update(visibility: Post::Visibilities::PRIVATE)
      expect(post.visible?(user)).to eq true
    end

    it "returns false if the post is private and the user is not the author" do
      post.update(visibility: Post::Visibilities::PRIVATE)
      expect(post.visible?(create(:user))).to eq false
    end
  end
end
