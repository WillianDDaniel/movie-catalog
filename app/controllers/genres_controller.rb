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
    if @genre.save
      redirect_to root_path
    end
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(name: params[:genre][:name])
      redirect_to @genre
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def show
    id = params[:id]
    @genre = Genre.find(id)
  end

  def destroy
    id = params[:id]
    genre = Genre.find(id)
    if genre.delete
      redirect_to root_path
    end
  end
end

