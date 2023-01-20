class Types::Inputs::BlobInput < Types::Base::InputObject
  argument :type,    Types::Enums::BlobTypeEnum, required: true
  argument :content, String,                     required: true
end
