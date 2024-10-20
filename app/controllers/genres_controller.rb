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

    if @genre.name.present?
      @genre.description = @genre.find_description(@genre.name)
    end

    if @genre.save
      redirect_to genres_path
    else
      @genre.valid?
      flash.now[:errors] = "O campo 'Nome do Gênero' não pode ficar vazio."

      render :new, status: :unprocessable_entity
    end
  end

  def edit ; end

  def update
    genre_name = params[:genre][:name]

    if genre_name.present?
      description = @genre.find_description(genre_name)
    end

    if @genre.update(name: genre_name, description: description)
      redirect_to @genre
    else
      @genre.valid?
      flash.now[:errors] = "O campo 'Nome do Gênero' não pode ficar vazio."

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

