require 'http'
require 'json'
require 'dotenv/load'

class GeminiService
  MAX_RETRIES = 3

  def self.generate_description(prompt)
    url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=#{ENV['GEMINI_API_KEY']}"
    headers = {
      'Content-Type' => 'application/json'
    }
    body = {
      contents: [
        {
          parts: [
            {
              text: prompt
            }
          ]
        }
      ]
    }.to_json

    retries = 0

    begin
      # Log to show an attempt is being made
      puts "Attempt #{retries + 1} to generate description for the prompt: '#{prompt}'"

      response = HTTP.post(url, headers: headers, body: body)
      response_data = JSON.parse(response.body)

      # Try to safely fetch data using 'dig' in arrays
      description = extract_description(response_data)

      if description
        puts "Description generated successfully."
        return description
      else
        raise "Description not found in attempts."
      end

    rescue => e
      retries += 1
      if retries < MAX_RETRIES
        puts "Error generating description: #{e.message}. Trying again... (Attempt #{retries})"
        sleep(1)
        retry
      else
        puts "Failed after #{MAX_RETRIES} attempts: #{e.message}. Returning empty description."
        return ""
      end
    end
  end

  # Method to try to extract the description by checking different possibilities
  def self.extract_description(response_data)
    # Check if the "candidates" array is present and contains valid data
    candidates = response_data.dig("candidates")

    # Iterate through possible "candidates" and their "parts"
    return nil unless candidates

    candidates.each do |candidate|
      parts = candidate.dig("content", "parts") || []
      parts.each do |part|
        description = part["text"]
        return description if description && !description.strip.empty?
      end
    end

    # In case no valid description is found
    nil
  end
end
