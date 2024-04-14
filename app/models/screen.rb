class Screen < ApplicationRecord
  belongs_to :schedule
  belongs_to :theater
  enum name: { screen1: 1, screen2: 2, screen3: 3 }

  validates :name, :date, presence: true
  validate :duplicate

  # 同じ劇場、同じスクリーン、同じ日付で、時間が被るものがあれば設定させない
  def duplicate
    schedule = Schedule.find_by(id: schedule_id)
    return if schedule.blank?

    screens = Screen.where(name: name, date: date, theater_id: theater_id)
      .joins(:schedule).merge(
        Screen.where(schedule: { start_time: [schedule.start_time..schedule.end_time] })
        .or(Screen.where(schedule: { end_time: [schedule.start_time..schedule.end_time] }))
      )
    errors.add(:base, '重複となるスクリーン設定がすでにあります。') if screens.present?
  end
end
