Rails.application.routes.draw do
  root 'home#index'

  get '/index' => 'results#index'
end
