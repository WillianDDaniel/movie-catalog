class Director < ApplicationRecord
  belongs_to :favorite_genre, class_name: 'Genre'
  has_many :movies

  validates :name, :favorite_genre_id, presence: true

  def self.tmdb_search_by_name(director_name)
    director = Director.new(name: director_name)
    director.favorite_genre = Genre.find_or_create_by(name: "Desconhecido")

    TmdbService.search_director_by_name(director)
  end
end
