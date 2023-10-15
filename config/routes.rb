Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'static_pages#top'
  get '/after_login', to: 'static_pages#after_login'
  get 'privacy', to: 'static_pages#privacy'

  post '/callback', to: 'line_bot_messages#callback'
  delete 'logout', to: 'users#destroy'

  resources :users, only: %i[new create]
  resource :profile, only: %i[new create show edit update]
  resources :tasks do
    member do
      put :change_status
    end
  end
end
