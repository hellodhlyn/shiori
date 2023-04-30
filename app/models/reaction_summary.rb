class ReactionSummary
  attr_accessor :total_count, :count_by_content, :viewer_reactions

  def initialize(reactions, viewer: nil)
    @total_count      = reactions.count
    @count_by_content = reactions.group(:content).count.map { |r, c| { content: r, count: c } }
    @viewer_reactions = viewer ? reactions.where(user: viewer) : []
  end
end
