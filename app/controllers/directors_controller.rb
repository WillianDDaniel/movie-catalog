class DirectorsController < ApplicationController
  def index
    @directors = Director.all
  end
  def new
    @director = Director.new
  end

  def create
    @director = Director.new(director_params)

    if @director.save
      redirect_to @director
    else
      @director.valid?
      @errors = @director.errors.messages

      flash.now[:errors] = @errors
      puts @errors

      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @director = Director.find(params[:id])

    if @director.movies.any?
      flash[:errors] = "Existem filmes associados a este diretor. Não pode ser removido."
      redirect_to directors_path
    else
      @director.destroy
      flash[:success] = "Diretor excluído com sucesso."
      redirect_to directors_path
    end
  end

  def show
    @director = Director.find(params[:id])
  end

  def edit
    @director = Director.find(params[:id])
  end

  def update
    @director = Director.find(params[:id])
    if @director.update(director_params)
      redirect_to @director
    else
      @director.valid?
      flash.now[:errors] = @director.errors.messages

      render :edit, status: :unprocessable_entity
    end
  end

  private
  def director_params
    params.require(:director).permit(:name, :nacionality, :birthdate, :favorite_genre_id)
  end
end
