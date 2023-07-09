module Resolvers
  class UserResolver < Resolvers::Base
    type Types::UserType, null: true

    argument :name, String, required: true

    def resolve(name:) = User.find_by(name: name)
  end
end
