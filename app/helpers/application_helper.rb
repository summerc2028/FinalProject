module ApplicationHelper

  def full_title(page_title)
    base_title = "Flipturn"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def is_active(action)
    params[:action] == action ? "active" : nil
  end
end
