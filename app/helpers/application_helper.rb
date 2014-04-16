module ApplicationHelper

  # Creates the title to be displayed in the taskbar 
  def full_title(page_title)
    base_title = "Daybraker"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end


  def is_active(controller, action)
    params[:controller] == controller and params[:action] == action ? "active" : nil
  end

end
