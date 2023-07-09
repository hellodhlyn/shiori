module Resolvers
  class ViewerResolver < Resolvers::Base
    type Types::ViewerType, null: false

    def resolve = current_user!
  end
end
