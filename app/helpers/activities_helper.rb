module ActivitiesHelper

	# Specifies format string for date (MM/DD/YYYY)
	def date_for(activity)
		activity.day.strftime("%B %e, %Y")
  end

	# Specifies formate string for time (12hr blank padded:minutes)
	def time_for(activity)
  	activity.time.strftime("%l:%M %p")
	end
end
