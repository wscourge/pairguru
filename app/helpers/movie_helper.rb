# frozen_string_literal: true

module MovieHelper
  def rating_class(rating)
    case rating
    when 1...4 then "text-danger"
    when 4..6 then "text-warning"
    when 6...8 then "text-info"
    when 8..10 then "text-success"
    else "text-muted"
    end
  end
end
