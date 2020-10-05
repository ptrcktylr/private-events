Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :delete]

  # Root Path
  root "users#index"

  # Signing Up
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # Logging Out
  delete '/logout', to: 'sessions#destroy'

  # Logging In
  post '/login', to: 'sessions#create'
end
