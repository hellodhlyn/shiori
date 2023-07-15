module Types::Interfaces::Blob
  include Types::Base::Interface

  implements GraphQL::Types::Relay::Node

  orphan_types *Types::BlobTypes.constants.map { Types::BlobTypes::const_get(_1) }.select { _1.is_a?(Class) }

  field :uuid, String, null: false
  field :type, Types::Enums::BlobTypeEnum, null: false
  field :content, String, null: true, deprecation_reason: "should use interface implementation fields instead of common `content` field"

  def type
    @object.class.name.demodulize.downcase
  end

  def content
    @object.try(:text)
  end

  definition_methods do
    def authorized?(object, context)
      super && object.visible?(context[:current_user])
    end

    def resolve_type(object, context)
      case object
      when Blobs::Markdown  then Types::BlobTypes::Markdown
      when Blobs::Plaintext then Types::BlobTypes::Plaintext
      when Blobs::Image     then Types::BlobTypes::Image
      else raise "Unexpected blob type"
      end
    end
  end
end
