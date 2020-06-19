Rails.application.routes.draw do
  root to: 'home#index'

  get '/admin_demote', action: 'demote', controller: 'admin/users',  as: 'demote_current_user'

  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  scope '/admin' do
    resources :users
  end

  resources :loans
  resources :items
  resources :categories

end
