class Types::Base::Object < GraphQL::Schema::Object
  field_class Types::Base::Field

  protected

  def current_user
    context[:current_user]
  end
end
