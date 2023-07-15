module Queries
  class ViewerQuery < Queries::BaseQuery
    type Types::ViewerType, null: false

    def resolve = current_user!
  end
end
