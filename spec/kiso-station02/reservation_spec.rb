require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'kiso-Station2 ダブルブッキングチェック' do
    let(:movie) { create(:movie) }
    let(:schedule) { create(:schedule, movie_id: movie.id) }
    let(:sheet) { create(:sheet) }
    let(:theater) { create(:theater) }
    let(:screen) {create(:screen, name: 1, schedule_id: schedule.id, theater_id: theater.id)}
    let(:reservation) { create(:reservation, { sheet_id: sheet.id, schedule_id: schedule.id, date: screen.date , theater_id: theater.id }) }
    let(:duplicated_reservation) { build(:reservation, { theater_id: theater.id, schedule_id: schedule.id, sheet_id: sheet.id, date: reservation.date }) }

    it "劇場、スケジュール、座席、時間帯が同じなら予約できない。" do
      expect(duplicated_reservation).not_to be_valid
    end
  end
end
