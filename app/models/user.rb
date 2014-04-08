class User < ActiveRecord::Base
	before_save { email.downcase! }
	before_save { username.downcase! }

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, 	presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :username, presence: true, length: { minimum: 6 }, uniqueness: { case_sensitive: false}
	has_secure_password
	validates :password, length: { minimum: 8 }
	before_create { generate_token :auth_token }

	private

		def User.new_auth_token
    	SecureRandom.urlsafe_base64
  	end

		def generate_token
			begin
				self[column] = User.new_auth_token
			end while User.exists?(column => self[column])
		end
end
