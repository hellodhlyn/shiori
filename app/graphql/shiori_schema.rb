class ShioriSchema < GraphQL::Schema
  use(GraphQL::Tracing::NewRelicTracing, set_transaction_name: true)

  mutation(Types::MutationType)
  query(Types::QueryType)

  # For batch-loading (see https://graphql-ruby.org/dataloader/overview.html)
  use GraphQL::Dataloader

  connections.add(ActiveRecord::Relation, Paginations::Connection)

  # GraphQL-Ruby calls this when something goes wrong while running a query:
  def self.type_error(err, context)
    super
  end

  # Union and Interface Resolution
  def self.resolve_type(abstract_type, obj, ctx)
    case obj
    when Post then Types::PostType
    when Blob then Types::Interfaces::Blob
    else raise GraphQL::Schema::InvalidTypeError
    end
  end

  # Relay-style Object Identification:

  # Return a string UUID for `object`
  def self.id_from_object(object, type_definition, query_ctx)
    object.to_sgid
  end

  # Given a string UUID, find the object
  def self.object_from_id(object_id, query_ctx)
    GlobalID::Locator.locate_signed(object_id)
  end
end
