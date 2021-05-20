Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
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
    resources :notes, module: :business do
      resources :comments
    end
  end
  resources :simulations
  resources :credentials, only: %i[edit update]
  resources :venues do
    resources :notes, module: :venue do
      resources :comments
    end
  end
end
