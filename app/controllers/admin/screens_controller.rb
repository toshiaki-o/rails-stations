class Admin::ScreensController < ApplicationController
  layout "admin"
  before_action :set_admin_screen, only: %i[edit update destroy]

  # GET /admin/screens or /admin/screens.json
  def index
    @screens = Screen.order(:theater_id, :date, :name)
  end

  # GET /admin/screens/new
  def new
    @screen = Screen.new
  end

  # GET /admin/screens/1/edit
  def edit; end

  # POST /admin/screens or /admin/screens.json
  def create
    @screen = Screen.new(admin_screen_params)
    if @screen.save
      redirect_to admin_screens_url, notice: "スクリーンの設定をしました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/screens/1 or /admin/screens/1.json
  def update
    if @screen.update(admin_screen_params)
      redirect_to admin_screens_url, notice: "スクリーンの設定を編集しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/screens/1 or /admin/screens/1.json
  def destroy
    @screen.destroy
    redirect_to admin_screens_url, notice: "スクリーン情報を削除しました。"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_screen
    @screen = Screen.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def admin_screen_params
    params.require(:screen).permit(:schedule_id, :name, :date, :theater_id)
  end
end
