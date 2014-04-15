class Exercise < ActiveRecord::Base

    validates :name, presence: true, length: { maximum: 50 }
  	validates :day, presence: true
	validates :time, presence: true
  	VALID_LENGTH_REGEX = /\A\d+:[0-5]\d\z/
 	validates :length, presence: true, format: { with: VALID_LENGTH_REGEX }
  	validate :user_id_exists
	belongs_to :user

end
