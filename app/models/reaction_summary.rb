class ReactionSummary
  attr_accessor :total_count, :count_by_content

  def initialize(reactions)
    @total_count      = reactions.count
    @count_by_content = reactions.group(:content).count.map { |r, c| { content: r, count: c } }
  end
end
