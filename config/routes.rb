Rails.application.routes.draw do
  devise_for :profiles
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "items#index"
  resources :users, only: [:index, :new, :create, :edit, :update]
  resources :items
end
