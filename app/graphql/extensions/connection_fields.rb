class Extensions::ConnectionFields < GraphQL::Schema::Field::ConnectionExtension
  class SortType < Types::Base::Enum
    value :CREATED_ASC
    value :CREATED_DESC
  end

  default_argument :sort, SortType, required: false, default_value: "CREATED_ASC"

  # @override
  def resolve(object:, arguments:, context:)
    next_args = arguments.dup
    next_args.delete(:first)
    next_args.delete(:last)
    next_args.delete(:before)
    next_args.delete(:after)
    next_args.delete(:sort)
    yield(object, next_args, arguments)
  end

  def after_resolve(**args)
    super(**args)
  end
end
