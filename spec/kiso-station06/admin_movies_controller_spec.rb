require 'rails_helper'

RSpec.describe Admin::MoviesController, type: :controller do
  render_views
  describe 'kiso-Station6 GET admin/movies' do
    context "ログインユーザに管理者権限のある場合" do
      before do
        sign_in create(:user, is_admin: 1)
        get :index
      end

      it "200を返すこと" do
        expect(response.status).to eq 200
      end
    end

    context "ログインユーザに管理者権限のない場合" do
      before do
        sign_in create(:user)
        get :index
      end

      it "200を返すこと" do
        expect(response.status).to eq 302
      end
    end
  end
end
