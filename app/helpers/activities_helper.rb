module ActivitiesHelper

  def date_for(activity)
    activity.day.strftime("%B %e, %Y")
  end
end
