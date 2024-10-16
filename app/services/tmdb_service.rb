require 'http'
require 'json'
require 'dotenv/load'

class TmdbService
  MAX_RETRIES = 3

  def self.search_movie(movie_name, year)
    base_url = "https://api.themoviedb.org/3/search/movie"

    query_params = {
      query: movie_name,
      include_adult: false,
      language: 'pt-BR',
      year: year
    }

    url = "#{base_url}?#{URI.encode_www_form(query_params)}"
    headers = {
      'accept' => 'application/json',
      'Authorization' => "Bearer #{ENV['TMDB_API_KEY']}"
    }

    retries = 0
    begin
      response = HTTP.get(url, headers: headers)
      response_data = JSON.parse(response.body)

      if response_data["results"] && response_data["results"].any?

        results = response_data["results"].first
        results["overview"]
      else
        raise "Nenhum filme encontrado ou resposta incompleta"
      end

    rescue => e
      retries += 1
      if retries < MAX_RETRIES
        puts "Erro ao buscar filme: #{e.message}. Tentando novamente... (Tentativa #{retries})"
        sleep(1)
        retry
      else
        puts "Falha após #{MAX_RETRIES} tentativas: #{e.message}"
        return nil
      end
    end
  end
end
