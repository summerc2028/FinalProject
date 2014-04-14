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

	def find_activities(user, date)
		current_time = Time.new
		act_list = user.activities.select {|activity| activity.day.eql? date and current_time.strftime("%H%M") <= activity.time.strftime("%H%M")}
    	return act_list.sort!{|x,y| x.time<=>y.time}
	end
end
