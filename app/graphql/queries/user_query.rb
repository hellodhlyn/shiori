module Queries
  class UserQuery < Queries::BaseQuery
    type Types::UserType, null: true

    argument :name, String, required: true

    def resolve(name:) = User.find_by(name: name)
  end
end
