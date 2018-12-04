Rails.application.routes.draw do
  root 'toppages#home'
  get '/home', to: 'toppages#home'
  get '/likes', to: 'likes#index'
  post 'toppages/follow'
  post 'toppages/unfollow'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: :logout
  resources :sessions, only: [:create, :destroy]
  resources :likes, only: [:index, :create, :destroy]
end
