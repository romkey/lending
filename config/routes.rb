Rails.application.routes.draw do
  root to: 'home#index'

  get '/admin_demote', action: 'demote', controller: 'users',  as: 'demote_current_user'
  get '/slack_import', action: 'import_from_slack', controller: 'users'

  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  scope '/admin' do
    resources :users
  end

  resources :loans
  get '/loans/cancel/:id', to: 'loans#cancel', as: 'cancel_loan'

  resources :items
  resources :categories

end
