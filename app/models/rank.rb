class Rank < ApplicationRecord
  belongs_to :movie
  with_options presence: true do
    validates :date
    validates :number
    validates :movie_id
    validates :number_of_reservations
  end
  validates :number, uniqueness: { scope: [:date, :movie_id] }

  class << self
    # 予約に基づく映画ランキング集計
    def movie(day: 30, limit: 5)
      movies = Reservation
        .joins(:schedule)
        .where(date: Time.current.ago(day.days)..Time.current)
        .group(:movie_id).order(count_all: :DESC)
        .limit(limit)
        .count

      movies.each.with_index(1) do |(movie, count), i|
        Rank.create!(date: Time.current, number: i, movie_id: movie, number_of_reservations: count)
      end
    end
  end
end
