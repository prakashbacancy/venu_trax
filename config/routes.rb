Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root to: 'businesses#index'
  get 'authorize' => 'auth#gettoken'
  get 'mail/index'

  get 'google_autication' => 'google_imap#authentication'
  get 'oauth2callback' => 'google_imap#callback'
  get 'get_access_code' => 'google_imap#get_access_code'
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
  resources :emails do
    post :reply
    collection do
      get :sent
      get :draft
      get :connect
      get :update_draft
      get :create_draft
      delete 'destroy_draft/:id', to: 'emails#destroy_draft', as: 'destroy_draft'
    end
  end
end
