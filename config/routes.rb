Rails.application.routes.draw do

devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks"}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "items#index"
  resources :items do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_size', defaults: { format: 'json' }
      get 'brand_search', defaults: { format: 'json' }
      match 'search', to: 'items#search', via: [:get, :post]
    end
    member do # itemのidと紐づけるためにmemberを使用
      get :buy
    end
  end
  resources :users, only: [:index, :new, :create, :show, :edit, :update] do
    
  # todo:ユーザーページのrootとcontroller要相談
    member do
      get :logout
      get :identification
      get :profile
    end
  end
  # マイページ
  resources :mypage, only: [:index] do
    member do
      get :profile
      get :logout
      get :identification
    end
  end
  # 新規登録ページ
  resources :signup do
    collection do
      get :step1
      get :step2
      get :step3
      get :step4 # ここで、入力の全て完了
      get :step5 # 登録完了後のページ
    end
  end
  
  #クレジットカード
  resources :card, only: [:new, :show, :create, :destroy]
  resources :purchase, only: [:show, :create, :update] do
    member do
      get :done,   to: 'purchase#done'
    end
  end
end