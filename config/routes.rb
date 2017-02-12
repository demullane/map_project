Rails.application.routes.draw do
  root 'home#index'

  post '/results' => 'home#results'
end
