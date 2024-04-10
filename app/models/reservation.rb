class Reservation < ApplicationRecord
  belongs_to :sheet
  belongs_to :schedule, dependent: :destroy
  with_options presence: true do
    validates :date
    validates :schedule_id
    validates :sheet_id
    validates :name
    validates :email
  end
  validates :schedule_id, uniqueness: { scope: [:sheet_id, :date] }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
