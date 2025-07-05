require 'rails_helper'

RSpec.describe "Chat API", type: :request do
  it "returns a reply for a prompt" do
    allow_any_instance_of(OpenAIService).to receive(:chat).and_return("Hello")
    post "/api/v1/chat", params: { prompt: "Hi" }
    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body)).to eq({"reply" => "Hello"})
  end
end