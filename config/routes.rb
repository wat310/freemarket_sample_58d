Rails.application.routes.draw do
  # profilesテーブルは消去の為使わない。
  # devise_for :profiles
  devise_for :users, :controllers => {
    :omniauth_callbacks =>  "users/omniauth_callbacks"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  
  root "items#index"


  #新規登録ページ
  get "signup", to: "signup#index"
resources :signup do
  collection do
    get 'step1'
    get 'step2'
    get 'step3'
    get 'step4' # ここで、入力の全て完了
    get 'step5'# 登録完了後のページ

  resources :items do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_size', defaults: { format: 'json' }
      get 'brand_search', defaults: { format: 'json' }
    end
  end

  resources :users, only: [:index, :new, :create, :show, :edit, :update] do
    
    # todo:ユーザーページのrootとcontroller要相談
    member do
      get'logout'
      get'identification'
      get'card'
      get'profile'
    end
  end

  # マイページ
  resources :mypage, only: [:index] do
     member do
      get :card
      get :profile
      get :logout
      get :identification
    end
  end

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
