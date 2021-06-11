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
    resources :notes, module: :business
    resources :venues
    resources :notes do
      resources :comments, module: :note
    end
  end
  resources :brands
  resources :settings do
    collection do
      get :field_options
    end
  end
  resources :groups do
    collection do
      get :change_position
    end
  end
  resources :fields do
    collection do
      get :change_position
      patch :change_position_in_table
      patch :change_header_view
      patch :toggle_visible_in_table
    end
    member do
      patch :change_properties
    end
  end
  resources :field_picklist_values do
    collection do
      get :change_klass
      get :change_field
      get :change_position
    end
  end
  resources :simulations
  resources :credentials, only: %i[edit update]
  resources :venues do
    resources :notes, module: :venue
    resources :attachments, module: :venue
    resources :meetings do
      resources :comments, module: :meeting
    end
    resources :notes do
      resources :comments, module: :note
    end
    resources :simulations do
      resources :comments, module: :simulation
    end
    resources :events
    resources :venue_contacts
    resources :revenue_sources
  end
  resources :meetings do
    collection do
      delete :destroy_all
      get :calendar
      get :calendar_meetings
      post :calendar_day_meetings
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
