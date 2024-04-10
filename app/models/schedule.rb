class Schedule < ApplicationRecord
  belongs_to :movie
  has_one :screen, dependent: :destroy
  has_many :reservations, dependent: :destroy
end
