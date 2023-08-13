Rails.application.routes.draw do
  root 'static_pages#top'
  get '/after_login', to: 'static_pages#after_login'

  post '/callback', to: 'line_bot_messages#callback'

  resources :users, only: %i[new create]
  resource :profile, only: %i[new create show edit update]
  resources :tasks
end
