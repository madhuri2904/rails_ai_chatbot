class ChatController < ApplicationController
  def index
    @reply = "hello"
  end

  def submit
    prompt = params[:prompt]
    @reply = OpenAIService.new.chat(prompt)
    render :index
  end
end
