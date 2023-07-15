module Types::BlobTypes
  class Markdown < Types::Base::Object
    implements Types::Interfaces::Blob
    field :text,      String, null: false
    field :text_html, String, null: false
  end

  class Plaintext < Types::Base::Object
    implements Types::Interfaces::Blob
    field :text, String, null: false 
  end

  class Image < Types::Base::Object
    implements Types::Interfaces::Blob
    field :url,         String, null: false
    field :preview_url, String, null: true
    field :blurhash,    String, null: true
    field :caption,     String, null: true
  end
end
