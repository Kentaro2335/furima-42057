Rails.application.routes.draw do
  devise_for :users
  resources :items, only: [:index]
  resources :users, only: [:edit, :update]
  resources :messages, only: [:index] 

  root to: 'items#index'

end


