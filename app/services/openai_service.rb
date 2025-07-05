# app/services/openai_service.rb

require 'net/http'
require 'uri'
require 'json'

class OpenaiService
  def initialize
    @api_key = ENV['OPENAI_API_KEY'] #|| 'your_openai_api_key_here'
    @uri = URI.parse("https://api.openai.com/v1/chat/completions")
  end

  def chat(prompt)
    puts "📡 OpenaiService#chat started"
    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = true
    http.read_timeout = 10 # Force timeout detection
  
    request = Net::HTTP::Post.new(@uri.request_uri)
    request["Content-Type"] = "application/json"
    request["Authorization"] = "Bearer #{@api_key}"
  
    request.body = {
      model: "gpt-4.1-mini",
      messages: [{ role: "user", content: prompt }],
      temperature: 0.7
    }.to_json
  
    response = http.request(request)
    puts "📥 Got response #{response.code}"
    Rails.logger.info "OpenAI raw response: #{response.code} - #{response.message}"

    if response.code.to_i == 200
      body = JSON.parse(response.body)
      { success: true, message: body["choices"][0]["message"]["content"] }
    else
      error_message = JSON.parse(response.body)["error"]["message"] rescue response.body
      { success: false, error: "OpenAI API Error: #{error_message}" }
    end
  rescue => e
    puts "🚨 Exception in OpenaiService: #{e.message}"
    return { success: false, error: "Exception: #{e.message}" }
  end
end
