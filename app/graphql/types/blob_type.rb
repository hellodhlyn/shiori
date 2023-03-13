module Types
  class BlobType < Types::Base::Object
    implements GraphQL::Types::Relay::Node

    def self.authorized?(object, context)
      super && object.visible?(context[:current_user])
    end

    field :uuid, String, null: false
    field :type, Types::Enums::BlobTypeEnum, null: false
    field :content, String, null: false

    def type
      @object.class.name.demodulize.downcase
    end

    def content
      @object.text
    end
  end
end
