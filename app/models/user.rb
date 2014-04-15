class User < ActiveRecord::Base
	before_save { email.downcase! }
	before_save { username.downcase! }

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
	validates :password, length: { minimum: 8 }, on: :create
	before_create :generate_token
	validates :auth_token, uniqueness: { case_sensitive: false }

	has_many :activities, dependent: :destroy
	has_many :exercises, dependent: :destroy
	has_many :foods, dependent: :destroy

	private

		def User.new_auth_token
    	SecureRandom.urlsafe_base64
  	end

		def generate_token
			begin
				self.auth_token = User.new_auth_token
			end while User.exists?(auth_token: self.auth_token)
		end
end
