class Paginations::Connection < GraphQL::Pagination::ActiveRecordRelationConnection
  def limited_nodes
    nodes = super

    case arguments[:sort]
    when "CREATED_ASC"  then
      nodes.order(created_at: :asc)
    when "CREATED_DESC"
      nodes.order(created_at: :desc)
    else
      nodes
    end
  end
end
