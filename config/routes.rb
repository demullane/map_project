Rails.application.routes.draw do
  root 'home#index'

  get '/results' => 'home#reload'
  post '/results' => 'home#results'
end
