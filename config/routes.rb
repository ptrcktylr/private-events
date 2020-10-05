Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :delete]

  # Root Path
  root "users#index"

  # Signing Up
  get '/signup', to: 'users#new', as: 'signup'
  # post '/signup', to: 'users#create'

  # Logging Out
  get '/logout', to: 'sessions#destroy', as: 'logout'

  # Logging In
  get '/login', to: 'sessions#new', as: 'login'
  # post '/login', to: 'sessions#create'
end
