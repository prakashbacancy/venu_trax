Rails.application.routes.draw do
  devise_for :users, controllers: { 
  	registrations: 'users/registrations',
  	passwords: 'users/passwords',
  	sessions: 'users/sessions'
  }
  root to: 'homes#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
