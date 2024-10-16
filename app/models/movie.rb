class Movie < ApplicationRecord
  belongs_to :director
  belongs_to :genre

  validates :title, :year, :country, :duration, :director_id, :genre_id, presence: true

  def movie_synopsis(movie_name, year)
    TmdbService.search_movie(movie_name, year)
  end
end
