Rails.application.routes.draw do
  root 'static_pages#top'
  get '/after_login', to: 'static_pages#after_login'

  resources :users, only: %i[new create]
end
