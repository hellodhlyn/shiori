module Types::BlobTypes
  class MarkdownBlob < Types::Base::Object
    implements Types::Interfaces::Blob
    field :text,      String, null: false
    field :text_html, String, null: false
  end

  class PlaintextBlob < Types::Base::Object
    implements Types::Interfaces::Blob
    field :text, String, null: false 
  end

  class ImageBlob < Types::Base::Object
    implements Types::Interfaces::Blob
    field :url,         String, null: false
    field :preview_url, String, null: true
    field :blurhash,    String, null: true
    field :caption,     String, null: true
  end
end
