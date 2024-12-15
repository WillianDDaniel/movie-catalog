require 'http'
require 'json'
require 'dotenv/load'

class TmdbService

  # This method searches for a movie in the TMDb API.
  # It receives the movie name and the year to compare if multiple results are found.
  def self.search_movie_info(movie)

    # Base URL for the TMDb API
    base_url = "https://api.themoviedb.org/3/search/movie"

    # Query parameters for the request, including the movie name and year
    query_params = {
      query: movie.title,
      include_adult: false,
      language: 'pt-BR',
      year: movie.year
    }

    # Construct the URL with the query parameters
    url = "#{base_url}?#{URI.encode_www_form(query_params)}"
    headers = {
      'accept' => 'application/json',
      'Authorization' => "Bearer #{ENV['TMDB_API_KEY']}"
    }

    # Making the HTTP request to the TMDb API
    response = HTTP.get(url, headers: headers)
    response_data = JSON.parse(response.body)

    if response_data["results"].any?
      movie_info = response_data["results"].first

      movie.synopsis = movie_info["overview"]
      movie.title = movie_info["title"]
      movie.original_title = movie_info["original_title"]
    end
  end

  def self.search_director_by_name(director)

    id = find_director_id(director.name)

    # Base URL
    base_url = "https://api.themoviedb.org/3/person/#{id}"

    # Parâmeters
    query_params = {
      language: 'pt-BR'
    }

    # Make the URL with the query parameters
    url = "#{base_url}?#{URI.encode_www_form(query_params)}"
    headers = {
      'accept' => 'application/json',
      'Authorization' => "Bearer #{ENV['TMDB_API_KEY']}"
    }

    # Make the HTTP request to the TMDb API
    response = HTTP.get(url, headers: headers)
    response_data = JSON.parse(response.body)

    if response_data

      director.nacionality = extract_country(response_data["place_of_birth"])
      director.birthdate = response_data["birthday"]
      director.name = response_data["name"]

      director
    else
      nil
    end
  end

  private

  def self.extract_country(place_of_birth)
    place_of_birth.split(", ").last
  end

  def self.find_director_id(director_name)
    # Base URL
    base_url = "https://api.themoviedb.org/3/search/person"

    # Parameters
    query_params = {
      query: director_name,
      include_adult: false,
      language: 'pt-BR'
    }

    # Build the URL with the query parameters
    url = "#{base_url}?#{URI.encode_www_form(query_params)}"
    headers = {
      'accept' => 'application/json',
      'Authorization' => "Bearer #{ENV['TMDB_API_KEY']}"
    }

    # Make the HTTP request to the TMDb API
    response = HTTP.get(url, headers: headers)
    response_data = JSON.parse(response.body)

    if response_data["results"].any?
      director_info = response_data["results"].first

      director_info["id"]
    else
      nil
    end
  end
end

