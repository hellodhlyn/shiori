module Types
  class BlobType < Types::Base::Object
    field :uuid, String, null: false
    field :type, Types::Enums::BlobTypeEnum, null: false
    field :content, String, null: false

    def type
      @object.class.name.demodulize.downcase
    end
  end
end
