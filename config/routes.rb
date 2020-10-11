Rails.application.routes.draw do
  resources :events
  resources :users
  resources :sessions, only: [:new, :create, :delete]

  resources :events, only: [:index, :show] do
    member do
      post 'events/:id/add_attendee', to: "events#add_attendee"
      delete 'events/:id/remove_attendee', to: "events#remove_attendee"
    end    
  end

  # Root Path
  root "events#index"

  # Signing Up
  get '/signup', to: 'users#new', as: 'signup'

  # Logging Out
  get '/logout', to: 'sessions#destroy', as: 'logout'

  # Logging In
  get '/login', to: 'sessions#new', as: 'login'
end
