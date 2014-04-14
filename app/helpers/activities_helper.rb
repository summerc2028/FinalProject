module ActivitiesHelper

  def date_for(activity)
    activity.day.strftime("%B %e, %Y")
  end

  def time_for(activity)
    activity.time.strftime("%l:%M %p")
  end
end
