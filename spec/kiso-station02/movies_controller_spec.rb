require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  render_views
  describe 'kiso-Station2 GET /movies/:id' do
    before do
      sign_in create(:user)
    end
    let!(:movie) { create(:movie) }
    let!(:schedule) { create(:schedule, movie_id: movie.id) }
    let!(:theater) { create(:theater) }
    let!(:screen) {create(:screen, name: 1, date: '2024-04-01', schedule_id: schedule.id, theater_id: theater.id)}
    let!(:date) { "2024-04-01" }
    let(:no_date_and_theater_request) { get :reservation, params: { id: movie.id, schedule_id: schedule.id }, session: {} }
    let(:no_date_and_schedule_request) { get :reservation, params: { id: movie.id, theater_id: theater.id }, session: {} }
    let(:no_schedule_and_theater_request) { get :reservation, params: { id: movie.id, date: date}, session: {} }
    let(:no_date_request) { get :reservation, params: { id: movie.id, schedule_id: schedule.id, theater_id: theater.id }, session: {} }
    let(:no_schedule_request) { get :reservation, params: { id: movie.id, date: date, theater_id: theater.id }, session: {} }
    let(:no_theater_request) { get :reservation, params: { id: movie.id, schedule_id: schedule.id, date: date }, session: {} }
    let(:unset_screen_request) { get :reservation, params: { id: movie.id, schedule_id: schedule.id, date: '2024-04-02', theater_id: theater.id }, session: {} }
    let(:success_request) { get :reservation, params: { id: movie.id, schedule_id: schedule.id, date: date, theater_id: theater.id }, session: {} }

    context "座席選択画面に遷移させない場合" do
      it 'date, theater_idの両方が渡されていないとき200を返していないこと' do
        no_date_and_theater_request
        expect(response.body).to include("この条件は予約できません。")
      end

      it 'date, schedule_idの両方が渡されていないとき200を返していないこと' do
        no_date_and_schedule_request
        expect(response.body).to include("この条件は予約できません。")
      end

      it 'schedule_id, theater_idの両方が渡されていないとき200を返していないこと' do
        no_schedule_and_theater_request
        expect(response.body).to include("この条件は予約できません。")
      end

      it 'dateが渡されていないとき200を返していないこと' do
        no_date_request
        expect(response.body).to include("この条件は予約できません。")
      end

      it 'schedule_idが渡されていないとき200を返していないこと' do
        no_date_request
        expect(response.body).to include("この条件は予約できません。")
      end

      it 'theater_idが渡されていないとき200を返していないこと' do
        no_date_request
        expect(response.body).to include("この条件は予約できません。")
      end

      it 'スクリーン設定がされていないとき200を返していないこと' do
        unset_screen_request
        expect(response.body).to include("この条件は予約できません。")
      end
    end

    context "座席選択画面に遷移させる場合" do
      it "date, schedule_id, theater_idが渡され、スクリーン設定がされているときだけ200を返すこと" do
        success_request
        expect(response.body).to include("座席の選択")
      end
    end
  end
end
