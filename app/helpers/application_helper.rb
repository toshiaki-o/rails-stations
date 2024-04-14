module ApplicationHelper
  def sheet_number(sheet_id)
    sheet = Sheet.find_by(id: sheet_id)
    "#{sheet.row}-#{sheet.column}"
  end

  def schedule_list
    schedules = Schedule.joins(:movie).where(movie: { is_showing: true }).order(:movie_id, :start_time)
    schedules.map do |schedule|
      [
        "#{l schedule.start_time,
             format: :time_only}～#{l schedule.end_time, format: :time_only} #{schedule.movie.name.truncate(10)}",
        schedule.id
      ]
    end
  end
end
