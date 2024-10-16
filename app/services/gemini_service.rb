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
      response = HTTP.post(url, headers: headers, body: body)
      response_data = JSON.parse(response.body)

      description = response_data["candidates"][0]["content"]["parts"][0]["text"]

      if description
        return description
      else
        raise "Resposta incompleta ou vazia"
      end

    rescue => e
      retries += 1
      if retries < MAX_RETRIES
        puts "Erro ao gerar descrição: #{e.message}. Tentando novamente... (Tentativa #{retries})"
        sleep(1)
        retry
      else
        puts "Falha após #{MAX_RETRIES} tentativas: #{e.message}"
        return nil
      end
    end

  end
end
