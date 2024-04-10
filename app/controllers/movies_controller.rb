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
  def show
    @schedules = @movie.schedules
  end

  def reservation
    redirect_to movie_path(params[:id]) if params[:schedule_id].blank? || params[:date].blank?
    @schedule = Schedule.find_by(id: params[:schedule_id])
    @sheets = Sheet.all
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_movie
    @movie = Movie.find(params[:id])
  end
end
