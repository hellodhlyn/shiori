class Types::Inputs::BlobInput < Types::Base::InputObject
  class TextInput < Types::Base::InputObject
    argument :text, String, required: true
  end

  class ImageInput < Types::Base::InputObject
    argument :url,         String, required: true
    argument :preview_url, String, required: false
    argument :blurhash,    String, required: false
    argument :caption,     String, required: false
  end

  argument :id,        ID, required: false
  argument :type,      Types::Enums::BlobTypeEnum, required: true
  argument :markdown,  TextInput, required: false
  argument :plaintext, TextInput, required: false
  argument :image,     ImageInput, required: false

  alias :type_argument :type

  def type
    "Blobs::#{type_argument.camelize}".constantize
  end

  def content
    case
    when type == Blobs::Markdown
      { "text" => markdown.text }
    when type == Blobs::Plaintext
      { "text" => plaintext.text }
    when type == Blobs::Image
      {
        "url"         => image.url,
        "preview_url" => image.preview_url,
        "blurhash"    => image.blurhash,
        "caption"     => image.caption,
      }
    else
      raise GraphQL::ExecutionError.new("Unexpected blob type: #{type_argument}")
    end
  end
end
