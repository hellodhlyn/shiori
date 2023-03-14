require "rails_helper"

RSpec.describe Blobs::Markdown, type: :model do
  describe "#text_html" do
    let(:blob) { create(:markdown_blob, content: { "text" => "# Title\n\nHello, **world**!" }) }

    it do
      expect(blob.text_html).to eq("<h1>Title</h1>\n<p>Hello, <strong>world</strong>!</p>\n")
    end
  end
end
