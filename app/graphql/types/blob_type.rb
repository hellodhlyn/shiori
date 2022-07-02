module Types
  class BlobEnum < Types::Base::Enum
    value "Markdown"
  end

  class BlobType < Types::Base::Object
    field :uuid, String, null: false
    field :type, Types::BlobEnum, null: false
    field :content, String, null: false

    def type
      @object.class.name.demodulize
    end
  end
end
