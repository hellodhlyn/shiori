module Mutations
  class Base::Mutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::Base::Argument
    field_class Types::Base::Field
    input_object_class Types::Base::InputObject
    object_class Types::Base::Object

    protected

    def current_user
      context[:current_user]
    end
  end
end
