module ApplicationHelper

  full_title(page_title) {
    base_title = "Flipturn"
    if base_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  }
end
