require 'http'
require 'json'

class OmdbService

  # This method searches for a movie in the OMDb API.
  # It uses the movie name and year to filter the results.
  def self.search_movie_info(movie)

    # Base URL for the OMDb API
    base_url = "https://www.omdbapi.com/"

    # Query parameters for the request, including the API key, movie name, and year
    query_params = {
      apikey: ENV['OMDB_API_KEY'],  # Use your OMDb API key from environment variable
      t: movie.original_title,                # Movie title
      y: movie.year                       # Movie release year
    }

    # Construct the URL with the query parameters
    url = "#{base_url}?#{URI.encode_www_form(query_params)}"

    # Making the HTTP request to the OMDb API
    response = HTTP.get(url)
    response_data = JSON.parse(response.body)

    # Check if the response indicates success
    if response_data["Response"] == "True"

      director_name = response_data["Director"]
      genre_name = response_data["Genre"].split(", ").first
      cover_url = response_data["Poster"]
      country = response_data["Country"].split(", ").last

      movie.cover_url = cover_url
      movie.country = country
      movie.duration = response_data["Runtime"].to_i

      return [director_name, genre_name]
    else
      nil
    end
  end

end
