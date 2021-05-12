Rails.application.routes.draw do
  root to: 'businesses#index'
  # for user functionality
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    sessions: 'users/sessions'
  }
  resources :users, path: '/manage/users'
  # devise_scope :user do
  #   get 'users/password' => 'users/passwords#index'
  # end
  # for business module
  resources :businesses do
    resources :venues
  end
  resources :simulations
  resources :credentials, only: %i[edit update]
  resources :venues
end
