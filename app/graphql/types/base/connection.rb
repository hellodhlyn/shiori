module Types
  class Base::Connection < Types::Base::Object
    include GraphQL::Types::Relay::ConnectionBehaviors

    edges_nullable false
    edge_nullable false
    node_nullable false
  end
end
