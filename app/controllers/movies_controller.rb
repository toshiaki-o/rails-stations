class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show reservation]

  # GET /movies or /movies.json
  def index
    @movies = params[:is_showing].blank? ? Movie.all : Movie.where(is_showing: params[:is_showing])
    if params[:keyword].present?
      @movies = @movies.where("name LIKE ?",
                              "%#{params[:keyword]}%").or(@movies.where("description LIKE ?",
                                                                        "%#{params[:keyword]}%"))
    end
  end

  # GET /movies/1 or /movies/1.json
  def show; end

  def reservation
    if check_required && Screen.find_by(reservation_params)
      @schedule = Schedule.find_by(id: params[:schedule_id])
      @sheets = Sheet.all
      @reserved_sheets = Reservation.where(reservation_params).pluck(:sheet_id)
    else
      flash.now[:danger] = "この条件は予約できません。"
      render :show
    end
  end

  def rank
    @ranks = Rank.where(date: Time.current).order(:number).limit(5)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_movie
    @movie = Movie.find(params[:id])
  end

  def reservation_params
    params.permit(:theater_id, :schedule_id, :date)
  end

  def check_required
    %i[theater_id schedule_id date].all? { |key| params.key?(key) }
  end
end
