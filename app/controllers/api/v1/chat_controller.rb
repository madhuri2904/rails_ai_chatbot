# app/controllers/chat

module Api
	module V1
		class ChatController < ApplicationController

	    # @reply = OpenAIService.new.chat(params[:prompt]) #Hot-wire response

		
			def create
				Rails.logger.info "Received chat request: #{params.inspect}"
			
				prompt = params[:message]
			
				if prompt.blank?
					Rails.logger.info "Prompt is blank."
					render json: { error: "Message can't be blank" }, status: :unprocessable_entity
					return
				end
			
				ai_response = OpenaiService.new.chat(prompt)
				Rails.logger.info "AI response: #{ai_response.inspect}"
			
				if ai_response[:success]
					render json: { response: ai_response[:message] }, status: :ok
				else
					render json: { error: ai_response[:error] }, status: :bad_request
				end
			end			
		end
  end
end
