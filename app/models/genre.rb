class Genre < ApplicationRecord
  has_many :movies
  has_many :directors

  validates :name, presence: true

  def genre_description(genre_name)

    prompt = "Descreva o gênero #{genre_name} com no máximo 450 caracteres."

    GeminiService.generate_description(prompt)
  end
end
