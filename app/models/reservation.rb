class Reservation < ApplicationRecord
  belongs_to :sheet
  belongs_to :schedule, dependent: :destroy
  with_options presence: true do
    validates :date
    validates :theater_id
    validates :schedule_id
    validates :sheet_id
    validates :name
    validates :email
  end
  validates :schedule_id, uniqueness: { scope: [:theater_id, :sheet_id, :date] }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :check_screen_settings

  # スクリーン設定されていない条件での予約はさせない。
  def check_screen_settings
    screen = Screen.find_by(schedule_id: schedule_id, date: date, theater_id: theater_id)

    errors.add(:base, 'この条件での予約はできません。') if screen.blank?
  end
end
