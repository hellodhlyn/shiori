class Types::Inputs::BlobInput < Types::Base::InputObject
  class TextInput < Types::Base::InputObject
    argument :text, String, required: true
  end

  argument :type,      Types::Enums::BlobTypeEnum, required: true
  argument :markdown,  TextInput, required: false
  argument :plaintext, TextInput, required: false

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
    else
      raise GraphQL::ExecutionError.new("Unexpected blob type")
    end
  end
end
