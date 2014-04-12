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

	# def sort_by_asc(column)
	# 	@users.sort!{|x1, x2| x1[column] <=> x2[column]}
	# end
	# def sort_by_dec(column)
	# 	@users.sort!{|x1,x2| x2[column] <=> x1[column]}
	# end
end
