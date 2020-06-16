Rails.application.routes.draw do
  resources :items
  resources :categories
  root to: 'home#index'

  devise_for :users
end
