Rails.application.routes.draw do
  get 'chat', to: "chat#index"
  # get 'chat/submit'
  # # Hotwire UI route
  # root "chat#index"
  # post "chat", to: "chat#submit"

  # API route for React frontend or external calls
  namespace :api do
    namespace :v1 do
      post 'chat', to: 'chat#create'
    end
  end
end
