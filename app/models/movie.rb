class Movie < ApplicationRecord
  has_many :schedules, dependent: :destroy
  has_many :ranks, dependent: :destroy
  validates :name, uniqueness: true
end
