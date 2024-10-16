class GenresController < ApplicationController

  def index
    @genres = Genre.all
  end
  def new
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def create
    @genre = Genre.new(name: params[:genre][:name])

    description = @genre.genre_description(@genre.name)

    @genre.description = description

    if @genre.save
      redirect_to root_path
    else
      @genre.valid?
      flash.now[:errors] = @genre.errors.messages

      render :new, status: :unprocessable_entity
    end
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(name: params[:genre][:name])
      redirect_to @genre
    else
      @genre.valid?
      flash.now[:errors] = @genre.errors.messages

      render :edit, status: :unprocessable_entity
    end
  end
  def show
    id = params[:id]
    @genre = Genre.find(id)
  end

  def destroy
    genre = Genre.find(params[:id])

    if genre.movies.any? || genre.directors.any?
      flash[:errors] = "Existem filmes ou diretores associados a este gênero. Não pode ser removido."
      redirect_to genres_path
    else
      genre.destroy
      flash[:success] = "Gênero excluído com sucesso."
      redirect_to genres_path
    end
  end


  private

end

