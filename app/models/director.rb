class Director < ApplicationRecord
  belongs_to :favorite_genre, class_name: 'Genre'
  has_many :movies

  validates :name, :favorite_genre_id, :nacionality, presence: true
end
