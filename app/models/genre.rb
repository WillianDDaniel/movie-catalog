class Genre < ApplicationRecord
  has_many :movies
  has_many :directors, foreign_key: 'favorite_genre_id'

  validates :name, presence: true

  def find_description(genre_name)

    genre_name = normalize_string(genre_name)

    if GenreDescription.exists?(genre_name: genre_name)
      GenreDescription.find_by(genre_name: genre_name).description
    else
      prompt = "Descreva o gênero de filmes #{genre_name} com no máximo 450 caracteres."
      GeminiService.generate_description(prompt)
    end
  end

  private
  def normalize_string(str)
    UnicodeUtils.downcase(str).tr("áàãâéêíóôõúüç", "aaaaeeiouuc")
  end
end
