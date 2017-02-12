Rails.application.routes.draw do
  root 'home#index'

  get '/results' => 'home#index'
  post '/results' => 'home#results'
end
