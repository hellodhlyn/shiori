module Types
  class Base::Field < GraphQL::Schema::Field
    argument_class Types::Base::Argument
  end
end
