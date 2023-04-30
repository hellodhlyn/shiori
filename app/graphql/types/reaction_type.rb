class Types::ReactionType < Types::Base::Object
  field :post,    Types::PostType, null: false
  field :user,    Types::UserType, null: false
  field :content, String,          null: false
end
