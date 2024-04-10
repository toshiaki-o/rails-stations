class Schedule < ApplicationRecord
  belongs_to :movie
  has_one :screen
  has_many :reservations
end
