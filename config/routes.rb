Rails.application.routes.draw do
  root 'toppages#home'
  get 'toppages/home'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: :logout
  resources :sessions, only: [:create, :destroy]
end
