class DirectorsController < ApplicationController
  def index
    @directors = Director.all
  end
  def new
    @director = Director.new
    @genres = Genre.all
  end

  def create
    @director = Director.new(director_params)

    if @director.save
      redirect_to @director
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def destroy
    @director = Director.find(params[:id])
    if @director.delete
      redirect_to root_path
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
      render :edit, status: :unprocessable_entity
    end
  end

  private 

  def director_params
    params.require(:director).permit(:name, :nacionality, :birthdate, :favorite_genre_id)
  end
end
