class Types::Base::Field < GraphQL::Schema::Field
  argument_class Types::Base::Argument
  connection_extension Extensions::ConnectionFields
end
