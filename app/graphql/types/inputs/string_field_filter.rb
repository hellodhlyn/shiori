class Types::Inputs::StringFieldFilter < Types::Base::InputObject
  argument :equal, String, required: false
  argument :start_with, String, required: false
  argument :contain, String, required: false

  def apply(query, field)
    case
    when equal.present?
      query.where(field => equal)
    when start_with.present?
      query.where("#{field} LIKE ?", "#{start_with}%")
    when contain.present?
      query.where("#{field} LIKE ?", "%#{contain}%")
    else
      query
    end
  end
end
