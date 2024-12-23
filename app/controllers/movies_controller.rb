class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie.where(isSketch: false)
  end

  def show ; end

  def new
    @movie = Movie.new
    @genres = Genre.all
    @directors = Director.all

    @movie_api_info = false
  end

  def create
    if params[:auto_fetch]
      @movie_api_info = true

      @genres = Genre.all
      @directors = Director.all

      @director, @genre, @movie = find_movie_info

      render :new, status: :unprocessable_entity

    elsif params[:accept_fetch]

    end
    # if @movie.save
    #   redirect_to @movie
    # else
    #   @movie.valid?
    #   flash.now[:errors] = 'Os seguintes campos não podem ficar vazios: '
    #   @errors = @movie.errors.messages

    #   @genres = Genre.all
    #   @directors = Director.all

    #   render :new, status: :unprocessable_entity
    # end
  end

  def edit
    @genres = Genre.all
    @directors = Director.all
  end

  def update
    if @movie.update(movie_params)
      redirect_to movie_path(@movie)
    else
      @movie.valid?
      flash.now[:errors] = 'Os seguintes campos não podem ficar vazios: '
      @errors = @movie.errors.messages

      @genres = Genre.all
      @directors = Director.all

      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @movie.destroy
      flash[:success] = "Filme excluído com sucesso."
      redirect_to movies_path
    else
      flash.now[:errors] = "Erro inesperado ao excluir o filme. Por favor, tente novamente."
      @movie.valid?
      render :show
    end
  end

  private
  def movie_params
    params.require(:movie).permit(
      :title, :year, :country, :synopsis, :isSketch,
      :duration, :director_id, :genre_id, :cover_url
    )
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def find_movie_info
    title = params[:movie][:title]
    year = params[:movie][:year]

    movie = Movie.new(title: title, year: year)

    Movie.search_movie_info_service(movie)
  end
end
