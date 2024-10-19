class DirectorsController < ApplicationController
  before_action :set_director, only: [:show, :edit, :update, :destroy]

  def index
    @directors = Director.all
  end

  def show ; end

  def new
    @director = Director.new
  end

  def create
    @director = Director.new(director_params)

    if @director.save
      redirect_to @director
    else
      @director.valid?
      flash.now[:errors] = @director.errors.messages

      render :new, status: :unprocessable_entity
    end
  end

  def edit ; end

  def update
    if @director.update(director_params)
      redirect_to @director
    else
      @director.valid?
      flash.now[:errors] = @director.errors.messages

      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @director.movies.any?
      flash[:errors] = "Existem filmes associados a este diretor. Não pode ser removido."
      redirect_to directors_path
    else
      @director.destroy
      flash[:success] = "Diretor excluído com sucesso."
      redirect_to directors_path
    end
  end

  private
  def director_params
    params.require(:director).permit(:name, :nacionality, :birthdate, :favorite_genre_id)
  end

  def set_director
    @director = Director.find(params[:id])
  end
end
