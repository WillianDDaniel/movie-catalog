class MoviesController < ApplicationController
  def index
    @movies = Movie.where(isSketch: false)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
    @genres = Genre.all
    @directors = Director.all
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to @movie
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to @movie
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    if @movie.delete
      redirect_to movies_path
    end
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :year, :country, :synopsis, :isSketch, :duration, :director_id, :genre_id, :cover_url)
  end

end
