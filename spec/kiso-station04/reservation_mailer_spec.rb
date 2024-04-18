require "rails_helper"

RSpec.describe ReservationMailer do
  let!(:user) { create(:user) }
  let!(:movie) { create(:movie) }
  let!(:schedule) { create(:schedule, movie_id: movie.id) }
  let!(:sheet) { create(:sheet) }
  let!(:theater) { create(:theater) }
  let!(:screen) {create(:screen, name: 1, schedule_id: schedule.id, theater_id: theater.id)}
  let!(:reservation) { create(:reservation, { name: user.name, email: user.email, sheet_id: sheet.id, schedule_id: schedule.id, date: screen.date , theater_id: theater.id }) }

  describe '#complete' do
    let(:email) { ReservationMailer.with(reservation: reservation).complete }
    it "subjectを検証する" do
      expect(email.subject).to eq "予約完了メールです"
    end
    it "送信先を検証する" do
      expect(email.to).to eq [user.email]
    end

    context "本文を検証する" do
      it '名前の表示があること' do
        expect(email.body).to include(user.name)
      end
      it '劇場名の表示があること' do
        expect(email.body).to include(theater.name)
      end
      it '映画名の表示があること' do
        expect(email.body).to include(movie.name)
      end
      it '上映時間の表示があること' do
        expect(email.body).to include(I18n.l schedule.start_time, format: :time_only)
      end
    end
  end
end