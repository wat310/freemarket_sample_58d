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
    get 'step4'
    get 'step5' # ここで、入力の全て完了
    get 'step6' # 登録完了後のページ
  end
end
end
