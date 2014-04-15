class Food < ActiveRecord::Base
  
    validates :name, presence: true, length: { maximum: 50 }
  	validates :day, presence: true
	validates :time, presence: true
  	validates :calories, presence: true, numericality: { only_integer: true }
  	validate :user_id_exists
	belongs_to :user

end
