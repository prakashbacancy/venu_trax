Rails.application.routes.draw do
  root to: 'homes#index'
  # for user functionality
  devise_for :users, controllers: { 
  	registrations: 'users/registrations',
  	passwords: 'users/passwords',
  	sessions: 'users/sessions'
  }
  # for business module
  resources :businesses
end
