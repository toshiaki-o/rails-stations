class ReservationsController < ApplicationController
  # GET /reservations/new
  def new
    redirect_to reservation_movie_path(params[:movie_id]) if params[:sheet_id].blank? || params[:date].blank?
    @reservation = Reservation.new(date: params[:date], sheet_id: params[:sheet_id], schedule_id: params[:schedule_id])
    @movie = Movie.find_by(id: params[:movie_id])
  end

  # POST /reservations or /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      redirect_to movie_path(params[:reservation][:movie_id]), notice: "予約が完了しました。"
    else
      redirect_to reservation_movie_path(params[:reservation][:movie_id], schedule_id: reservation_params[:schedule_id], date: reservation_params[:date]), notice: "その座席はすでに予約済みです"
    end
  end


  private
    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:schedule_id, :sheet_id, :name, :email, :date)
    end
end
