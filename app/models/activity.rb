class Activity < ActiveRecord::Base
  before_save { length.upcase! }

  validates :name, presence: true, length: { maximum: 50 }
  validates :day, presence: true
  validates :time, presence: true
  VALID_LENGTH_REGEX = /\A(0|1)?\d:[0-5]\d (A|P)M\z/i
  validates :length, presence: true, format: { with: VALID_LENGTH_REGEX }
  validates :location, presence: true, length: { maximum: 16 }
  belongs_to :user
end
