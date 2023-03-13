module Types::Interfaces::Blob
  include Types::Base::Interface

  implements GraphQL::Types::Relay::Node

  orphan_types Types::MarkdownBlobType, Types::PlaintextBlobType

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
      when Blobs::Markdown  then Types::MarkdownBlobType
      when Blobs::Plaintext then Types::PlaintextBlobType
      else raise "Unexpected blob type"
      end
    end
  end
end
