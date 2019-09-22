Rails.application.routes.draw do
  devise_for :profiles
  devise_for :users, :controllers => {
    :omniauth_callbacks =>  "users/omniauth_callbacks",
    # :registrations => "users/registrations",
    # sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  
  root "items#index"
  resources :users, only: [:index, :new, :create, :show, :edit, :update]
  resources :items

  #新規登録ページ
  get "signup", to: "signup#index"
resources :signup do
  collection do
    get 'step1'
    get 'step2'
    get 'step3'
    get 'step4' # ここで、入力の全て完了
    get 'step5'# 登録完了後のページ
  end
end

#クレジットカードページ
get "credit_card", to: "credit_card#index"
resources :credit_card, only: [:new, :create, :show, :edit] do
  collection do
    post 'delete', to: 'credit_card#delete'
    post 'show'
  end
  member do
    get 'confirmation'
  end
end 

end
