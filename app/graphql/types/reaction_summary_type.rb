module Types
  class ReactionCountType < Types::Base::Object
    field :content, String,  null: false
    field :count,   Integer, null: false
  end

  class ReactionSummaryType < Types::Base::Object
    field :total_count,      Integer,                    null: false
    field :count_by_content, [Types::ReactionCountType], null: false
  end
end
