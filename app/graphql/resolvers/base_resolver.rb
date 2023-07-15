module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    argument_class Types::Base::Argument

    protected

    def current_user
      context[:current_user]
    end

    def current_user!
      context[:current_user] or raise GraphQL::ExecutionError.new("Unauthorized")
    end
  end
end
