class ReservationsController < ApplicationController
  # GET /reservations/new
  def new
    redirect_to reservation_movie_path(params[:movie_id]) if params[:sheet_id].blank? || params[:date].blank?
    @reservation = Reservation.new(date: params[:date], sheet_id: params[:sheet_id], schedule_id: params[:schedule_id],
                                   theater_id: params[:theater_id], name: current_user.name, email: current_user.email)
    @movie = Movie.find_by(id: params[:movie_id])
  end

  # POST /reservations or /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      ReservationMailer.with(reservation: @reservation).complete.deliver_later
      redirect_to movie_path(params[:reservation][:movie_id]), flash: { info: "予約が完了しました。" }
    else
      redirect_to reservation_movie_path(params[:reservation][:movie_id],
                                         schedule_id: reservation_params[:schedule_id],
                                         date: reservation_params[:date],
                                         theater_id: reservation_params[:theater_id]),
                  flash: { danger: "その座席はすでに予約済みです" }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:theater_id, :schedule_id, :sheet_id, :name, :email, :date)
  end
end
