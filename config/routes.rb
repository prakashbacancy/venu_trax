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
  resources :settings do
    collection do
      get :field_options
    end
  end
  resources :fields
  resources :field_picklist_values do
    collection do
      get :change_klass
      get :change_field
      get :change_position
    end
  end
  resources :simulations
  resources :credentials, only: %i[edit update]
  resources :venues
end
