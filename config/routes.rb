Rails.application.routes.draw do
  resources :loans
  resources :items
  resources :categories
  root to: 'home#index'

  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }
end
