Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  scope '/admin' do
    resources :users
  end

  resources :loans
  resources :items
  resources :categories

end
