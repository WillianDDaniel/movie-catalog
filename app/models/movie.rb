class Movie < ApplicationRecord
  belongs_to :director
  belongs_to :genre

  validates :title, :year, :country, :duration, :director_id, :genre_id, presence: true
end
