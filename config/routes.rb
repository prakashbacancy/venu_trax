Rails.application.routes.draw do
  root to: 'homes#index'
  # for user functionality
  devise_for :users, path: 'user', controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    sessions: 'users/sessions'
  }
  resources :users
  # devise_scope :user do
  #   get 'users/password' => 'users/passwords#index'
  # end
  # for business module
  resources :businesses
  resources :simulations
end
