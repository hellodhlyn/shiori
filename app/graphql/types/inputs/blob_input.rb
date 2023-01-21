class Types::Inputs::BlobInput < Types::Base::InputObject
  argument :type,    Types::Enums::BlobTypeEnum, required: true
  argument :content, String,                     required: true

  alias :type_argument :type

  def type
    "Blobs::#{type_argument.camelize}".constantize
  end
end
