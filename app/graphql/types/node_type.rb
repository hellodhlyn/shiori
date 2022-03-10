module Types
  module NodeType
    include Types::Base::Interface
    include GraphQL::Types::Relay::NodeBehaviors
  end
end
