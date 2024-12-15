class Movie < ApplicationRecord
  belongs_to :director
  belongs_to :genre

  validates :title, :year, :country, :duration, :director_id, :genre_id, presence: true


  def self.search_movie_info_service(movie)
    # fill movie with Original_title, Synopsis, Title
    TmdbService.search_movie_info(movie)

    # fill movie with Cover_url, Country, Duration and return director_name and genre_name
    director_name, genre_name = OmdbService.search_movie_info(movie)

    director = Director.tmdb_search_by_name(director_name)
    genre = Genre.search_by_english_name(genre_name)

    if director.valid? && genre.valid?
      [director, genre, movie]
    end
  end
end
