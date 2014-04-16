module UsersHelper
	def gravatar_for(user)
  	gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
  	gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?size=150"
  	image_tag(gravatar_url, alt: user.fname, class: "img-thumbnail profile-pic")
	end

	def birthdate_for(user)
		user.birthdate.strftime("%B %e, %Y")
	end

	def time_for(user)
		user.to_formatted_s(:long_ordinal)
	end

	def limit_activity(activities)
		current_time = Time.new
		return activities.select {|activity| current_time.strftime("%H%M")<=activity.time.strftime("%H%M")}
	end

	def sort_foods(foods)
		return foods.sort {|x,y| x.time.strftime("%H%M")<=>y.time.strftime("%H%M")}
	end

	def calculate_net_calories(foods,exercises)
		total_intake = 0
		total_burn = 0
		foods.each do |food|
			total_intake += food.calories
		end
		exercises.each do |exercise|
			total_burn += exercise.calories
		end
		return total_intake-total_burn
	end

	def calculate_monthly_calories(exercises)
		total_burn = 0
		exercises.each do |exercise|
			total_burn += exercise.calories
		end
		return total_burn
	end
end
