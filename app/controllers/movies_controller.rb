class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.all.includes([:genre]).decorate
  end

  def show
    @movie = Movie.includes([:genre]).find(params[:id]).decorate
  end

  def send_info
    MovieInfoMailer.send_info(current_user.id, params[:id]).deliver_later
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporterJob.perform_later(user_id: current_user.id, file_path: file_path)
    redirect_to root_path, notice: "Movies exported"
  end
end
