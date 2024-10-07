class HomeController < ApplicationController
  def index
    @genres = Genre.all
    @directors = Director.all
  end
end
