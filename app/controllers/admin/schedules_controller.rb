class Admin::SchedulesController < ApplicationController
  layout "admin"
  before_action :admin_user!
  before_action :set_admin_schedule, only: %i[show edit update destroy]

  # GET /admin/schedules or /admin/schedules.json
  def index
    @schedules = Schedule.includes(:movie).page(params[:page]).per(15).order(:movie_id, :start_time)
  end

  # GET /admin/schedules/1 or /admin/schedules/1.json
  def show; end

  # GET /admin/schedules/new
  def new
    @schedule = Schedule.new(movie_id: params[:movie_id])
  end

  # GET /admin/schedules/1/edit
  def edit; end

  # POST /admin/schedules or /admin/schedules.json
  def create
    @schedule = Schedule.new(admin_schedule_params)

    if @schedule.save
      redirect_to admin_schedules_path, notice: "上映スケジュールを作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/schedules/1 or /admin/schedules/1.json
  def update
    if @schedule.update(admin_schedule_params)
      redirect_to admin_schedules_path, notice: "上映スケジュールを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/schedules/1 or /admin/schedules/1.json
  def destroy
    @schedule.destroy
    redirect_to admin_schedules_url, notice: "上映スケジュールを削除しました。"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_schedule
    @schedule = Schedule.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def admin_schedule_params
    params.require(:schedule).permit(:movie_id, :start_time, :end_time)
  end
end
