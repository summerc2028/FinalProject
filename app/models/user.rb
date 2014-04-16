class User < ActiveRecord::Base
	# Relationships
	has_many :activities, dependent: :destroy, validate: true
	has_many :exercises, dependent: :destroy, validate: true
	has_many :foods, dependent: :destroy, validate: true

	#Before information is stored the email and username are converted to all lowercase
	before_save { email.downcase! }
	before_save { username.downcase! }

	# Define all validations for data
	validates :fname, presence: true, length: { maximum: 50 }
	validates :lname, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, 	presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  	validates :username, presence: true, length: { in: 6..16 }, uniqueness: { case_sensitive: false }
	validates :height, numericality: { only_integer: true }, allow_nil: true
	validates :weight, numericality: { only_integer: true }, allow_nil: true
	VALID_GENDER_REGEX = /\A(Male)|(Female)\z/
	validates :gender, format: { with: VALID_GENDER_REGEX }, allow_nil: true
	validates :birthdate, timeliness: { on_or_before: lambda { Date.current }, type: :date }, allow_nil: true
	validates :status, length: { maximum: 140 }, allow_nil: true
	has_secure_password
	validates :password, length: { minimum: 8 }, allow_nil: true
	before_create :generate_token
	validates :auth_token, uniqueness: { case_sensitive: false }

	private
		# Defines a randlomy generated secure token
		def User.new_auth_token
    		SecureRandom.urlsafe_base64
  		end

  		# Generates a token for the user
		def generate_token
			begin
				self.auth_token = User.new_auth_token
			end while User.exists?(auth_token: self.auth_token)
		end
end
