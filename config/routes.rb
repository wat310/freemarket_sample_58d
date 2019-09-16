Rails.application.routes.draw do
  devise_for :profiles
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "items#index"
  resources :users, only: [:index, :new, :create, :show, :edit, :update]
  resources :items

  #新規登録ページ
resources :signup do
  collection do
    get 'step1'
    get 'step2'
    get 'step3'
    get 'step4'
    get 'step5'
    get 'step6' # ここで、入力の全て完了
    get 'done' # 登録完了後のページ
  end
end
end

