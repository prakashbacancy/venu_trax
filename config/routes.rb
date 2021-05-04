Rails.application.routes.draw do
  root to: 'businesses#index'
  # for user functionality
  devise_for :users, controllers: { 
  	registrations: 'users/registrations',
  	passwords: 'users/passwords',
  	sessions: 'users/sessions'
  }
  # devise_scope :user do
  #   get 'users/password' => 'users/passwords#index'
  # end
  # for business module
  resources :businesses
  resources :simulations
end
