module ApplicationHelper

  def format_error_messages(errors)
    translated_attributes = {
      name: "nome",
      favorite_genre_id: "gênero",
      nacionality: "nacionalidade",

      title: "nome do filme",
      year: "ano de lançamento",
      country: "país",
      synopsis: "sinopse",
      duration: "duração",
      director_id: "diretor",
      genre_id: "gênero",
    }

    missing_fields = errors.keys.map do |attribute|
      translated_attributes[attribute]
    end.compact

    "Os seguintes campos precisam ser preenchidos: #{missing_fields.join(', ')}"
  end
end
