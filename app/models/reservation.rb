class Reservation < ApplicationRecord
  belongs_to :sheet
  belongs_to :schedule
  with_options presence: true do
    validates :date
    validates :schedule_id
    validates :sheet_id
    validates :name
    validates :email
  end
  validates :schedule_id, uniqueness: { scope: [:sheet_id, :date] }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
end
