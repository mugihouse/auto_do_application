Rails.application.routes.draw do
  root 'application#index'
  
  resource :user, only: %i[new create]
end
