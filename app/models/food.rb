class Food < ActiveRecord::Base
	# Relationships
  belongs_to :user, validate:true

  # Defines the ordering of activities. in this case they are ordered by date ascending
	default_scope -> { order('day ASC') }

  # Define all validations for data
  validates :name, presence: true, length: { maximum: 50 }
	validates :day, presence: true
	validates :time, presence: true
  validates :calories, presence: true, numericality: { only_integer: true }
	validate :user_id_exists

  private

    # Private method to determine if a user id exists in the database
    def user_id_exists
      begin
        User.find(self.user_id)
      rescue ActiveRecord::RecordNotFound
        errors.add(:user_id, "user_id foreign key must exist")
        false
      end
    end
end
