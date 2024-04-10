class Screen < ApplicationRecord
  belongs_to :schedule
  enum name: { screen1: 1, screen2: 2, screen3: 3 }

  validates :name, :schedule_id, :date, presence: true
  validate :duplicate

  def duplicate
    schedule = Schedule.find_by(id: schedule_id)
    return if schedule.blank?
    screens = Screen.where(name: name, date: date)
              .joins(:schedule).merge(
                Screen.where(schedule: {start_time: [schedule.start_time..schedule.end_time]})
                .or(Screen.where(schedule: {end_time: [schedule.start_time..schedule.end_time]}))
              )
    if screens.present?
      errors.add(:schedule_id, 'が重複する時間帯に登録はできません。')
    end
  end
end
