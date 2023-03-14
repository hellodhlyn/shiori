module Blobs
  class Markdown < Blob
    blob_attribute :text

    def text_html
      @text_html ||= GitHub::Markup.render_s(GitHub::Markups::MARKUP_MARKDOWN, text)
    end
  end
end
