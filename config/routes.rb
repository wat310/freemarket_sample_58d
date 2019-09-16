Rails.application.routes.draw do
  devise_for :profiles
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "items#index"
  resources :users, only: [:index, :new, :create, :edit, :update]

  resources :items do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_size', defaults: { format: 'json' }
      get 'brand_search', defaults: { format: 'json' }
    end
  end

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

