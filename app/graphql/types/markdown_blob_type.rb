class Types::MarkdownBlobType < Types::Base::Object
  implements Types::Interfaces::Blob

  field :text,      String, null: false
  field :text_html, String, null: false
end
