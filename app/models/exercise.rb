class Exercise < ActiveRecord::Base
	belongs_to :user, validate:true

	default_scope -> { order('time ASC') }

	validates :name, presence: true, length: { maximum: 50 }
  	validates :day, presence: true
	validates :time, presence: true
 	validates :calories, presence: true, numericality: { only_integer: true }
  	validate :user_id_exists

  private

    def user_id_exists
      begin
        User.find(self.user_id)
      rescue ActiveRecord::RecordNotFound
        errors.add(:user_id, "user_id foreign key must exist")
        false
      end
    end
end
