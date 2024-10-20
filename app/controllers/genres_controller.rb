class GenresController < ApplicationController
  before_action :set_genre, only: [:show, :edit, :update, :destroy]

  def index
    @genres = Genre.all
  end

  def show ; end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(name: params[:genre][:name])

    @genre.description = @genre.find_description(@genre.name)

    if @genre.save
      redirect_to genres_path
    else
      @genre.valid?
      flash.now[:errors] = @genre.errors.messages

      render :new, status: :unprocessable_entity
    end
  end

  def edit ; end

  def update
    if @genre.update(name: params[:genre][:name])
      redirect_to @genre
    else
      @genre.valid?
      flash.now[:errors] = @genre.errors.messages

      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @genre.movies.any? || @genre.directors.any?
      flash[:errors] = "Existem filmes ou diretores associados a este gênero. Não pode ser removido."
      redirect_to genres_path
    else
      @genre.destroy
      flash[:success] = "Gênero excluído com sucesso."
      redirect_to genres_path
    end
  end


  private
  def set_genre
    @genre = Genre.find(params[:id])
  end
end

