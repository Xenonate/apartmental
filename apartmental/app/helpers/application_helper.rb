module ApplicationHelper
  def get_weight(type, param)
    if param
      type = param
    else
      type = 0.25
    end
  end
end
