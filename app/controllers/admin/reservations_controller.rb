class Admin::ReservationsController < ApplicationController
  layout "admin"
  before_action :set_reservation, only: %i[show edit update destroy]

  # GET /admin/reservations or /admin/reservations.json
  def index
    @reservations = Reservation.joins({ schedule: :movie }).where(movie: { is_showing: true })
  end

  # GET /admin/reservations/1 or /admin/reservations/1.json
  def show; end

  # GET /admin/reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /admin/reservations/1/edit
  def edit; end

  # POST /admin/reservations or /admin/reservations.json
  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      redirect_to admin_reservations_url, notice: "作成しました。"
    else
      render :new, status: :bad_request, notice: "作成に失敗しました。"
    end
  end

  # PATCH/PUT /admin/reservations/1 or /admin/reservations/1.json
  def update
    if @reservation.update(reservation_params)
      redirect_to admin_reservations_url, notice: "予約を変更しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/reservations/1 or /admin/reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to admin_reservations_url, notice: "削除しました。" }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:theater_id, :schedule_id, :sheet_id, :name, :email, :date)
  end
end
