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

  describe "#blobs=" do
    let(:post) { create(:post) }
    let(:old_blobs) do
      create_list(:plaintext_blob, 3, post: post).tap do |blobs|
        blobs.each_with_index { |blob, index| blob.update!(index: index) }
      end
    end

    subject { post.update!(blobs: new_blobs); post.reload }

    shared_examples "having only updated blobs" do
      it do
        expect(subject.blobs.size).to eq new_blobs.size
        expect(subject.blobs.map(&:content)).to eq new_blobs.map(&:content)
        expect(subject.blobs.map(&:index)).to eq (0...new_blobs.size).to_a
      end
    end

    context "completely new blobs" do
      let(:new_blobs) { [0..2].map { Blobs::Markdown.new(text: Faker::Lorem.paragraph) } }
      it_behaves_like "having only updated blobs"
    end

    context "update existing blobs" do
      let(:new_blobs) do
        [
          old_blobs[0],
          Blobs::Markdown.new(text: Faker::Lorem.paragraph),
          old_blobs[2],
        ]
      end

      it_behaves_like "having only updated blobs"

      it "should destroy the old blobs" do
        subject
        expect { old_blobs[1].reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
