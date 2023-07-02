class Types::Base::Object < GraphQL::Schema::Object
  field_class Types::Base::Field
  connection_type_class Types::Base::Connection

  protected

  def current_user
    context[:current_user]
  end
end
