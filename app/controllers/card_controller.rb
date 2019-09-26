class CardController < ApplicationController
  # WIP:クレジットカード実装中
  require "payjp"

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to action: "show" if card.exists?
  end

  def pay #payjpとCardのデータベース作成
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card) 
      # binding.pry
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete #PayjpとCardデータベースを削除
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "new"
  end

  def show #Cardのデータpayjpに送り情報を取り出す
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end
end

#   def new
#     card = Card.where(user_id: current_user.id)
#     if card.exists?
#       redirect_to action: "show"
#     else
#       redirect_to action: "step4"
#   end

#   def step4
#   end

# #クレジットカード登録
#   def pay
#     Payjp.api_key = "sk_test_231db21bf968f965920e0058"
#     # テスト鍵セット(TODO:環境変数にする)
#     if params['payjpToken'].blank?
#     # paramsの中にjsで作った'payjpTokenが存在するか確認
#       redirect_to action: "new"
#     else
#       customer = Payjp::Customer.create(
#       card: params['payjpToken'],
#       metadata: {user_id: current_user.id}
#       )
#     # ↑ここでjay.jpに保存
#       @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
#     # ここでdbに保存
#       if @card.save
#         redirect_to action: "show"
#         flash[:notice] = 'クレジットカードの登録が完了しました'
#       else
#         redirect_to action: "pay"
#         flash[:alert] = 'クレジットカード登録に失敗しました'
#       end
#     end
#   end

# #クレジットカード詳細ページ
#     def show
#       # @card = current_user.credit_card
#       # if card.blank?
#       #   redirect_to action: "new" 
#       # else
#       #   Payjp.api_key = "sk_test_231db21bf968f965920e0058"
#       #   customer = Payjp::Customer.retrieve(card.customer_id)
#       #   @customer_card = customer.cards.retrieve(card.card_id)
#       # end
#   end

# #クレジットカード購入
#   def buy
#     if card.blank?
#       redirect_to action: "new"
#       flash[:alert] = '購入にはクレジットカード登録が必要です'
#     else
#       @product = Product.find(params[:product_id])
#      # 購入した際の情報を元に引っ張ってくる
#       card = current_user.credit_card
#      # テーブル紐付けてるのでログインユーザーのクレジットカードを引っ張ってくる
#       Payjp.api_key = "sk_test_231db21bf968f965920e0058"
#      # キーをセットする(環境変数においても良い)
#       Payjp::Charge.create(
#       amount: @product.price, #支払金額
#       customer: card.customer_id, #顧客ID
#       currency: 'jpy', #日本円
#       )
#      # ↑商品の金額をamountへ、cardの顧客idをcustomerへ、currencyをjpyへ入れる
#       if @product.update(status: 1, buyer_id: current_user.id)
#         flash[:notice] = '購入しました。'
#         redirect_to controller: "products", action: 'show'
#       else
#         flash[:alert] = '購入に失敗しました。'
#         redirect_to controller: "products", action: 'show'
#       end
#      #↑この辺はこちら側のテーブル設計どうりに色々しています
#     end
#   end

#   def delete
#     card = current_user.credit_card
#     if card.blank?
#       redirect_to action: "new"
#     else
#       Payjp.api_key = 'sk_test_231db21bf968f965920e0058'
#       customer = Payjp::Customer.retrieve(card.customer_id)
#       customer.delete
#      #ここでpay.jpの方を消している
#       card.delete
#      #ここでテーブルにあるcardデータを消している
#     end  
#   end
# end

  # def create
  # end

  #   #--------カード追加--------
  # def new
  #   # card = Card.where(user_id: current_user.id)
  #   # redirect_to action: "show" if card.exists?
  # end

  #   #--------カード情報--------
  # def show
  #   # card = current_user.credit_card
  #   # if card.blank?
  #   #   redirect_to action: "new" 
  #   # else
  #   #   Payjp.api_key = "sk_test_0e2eb234eabf724bfaa4e676"
  #   #   customer = Payjp::Customer.retrieve(card.customer_id)
  #   #   @customer_card = customer.cards.retrieve(card.card_id)
  #   # end
  # end

  # #--------カード編集--------
  # def edit
  # end

  # #-----カード登録-----
  # def pay
  #   Payjp.api_key = "sk_test_231db21bf968f965920e0058"
  #   # ここでテスト鍵をセット(TODO:環境変数に変更する)
  #   if params['payjpToken'].blank?
  #   # paramsの中にjsで作った'payjpTokenが存在するか確かめる
  #     redirect_to action: "new"
  #   else
  #     customer = Payjp::Customer.create(
  #     card: params['payjpToken'],
  #     metadata: {user_id: current_user.id}
  #     )
  #    # ↑ここでjay.jpに保存
  #     @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
  #    # ここでdbに保存
  #     if @card.save
  #       redirect_to action: "show"
  #       flash[:notice] = 'クレジットカードの登録が完了しました'
  #     else
  #       redirect_to action: "pay"
  #       flash[:alert] = 'クレジットカード登録に失敗しました'
  #     end
  #   end
  # end

  #   #--------カード決済--------
  #   def buy 

  #     if card.blank?
  #       redirect_to action: "new"
  #       flash[:alert] = '購入にはクレジットカード登録が必要です'
  #     else
  #       @product = Product.find(params[:product_id])
  #      # 購入した際の情報を元に引っ張ってくる
  #       card = current_user.credit_card
  #      # テーブル紐付けてるのでログインユーザーのクレジットカードを引っ張ってくる
  #       Payjp.api_key = "sk_test_231db21bf968f965920e0058"
  #      # キーをセットする(環境変数においても良い)test-key
  #       Payjp::Charge.create(
  #       amount: @product.price, #支払金額
  #       customer: card.customer_id, #顧客ID
  #       currency: 'jpy', #日本円
  #       )
  #      # ↑商品の金額をamountへ、cardの顧客idをcustomerへ、currencyをjpyへ入れる
  #       if @product.update(status: 1, buyer_id: current_user.id)
  #         flash[:notice] = '購入しました。'
  #         redirect_to controller: "products", action: 'show'
  #       else
  #         flash[:alert] = '購入に失敗しました。'
  #         redirect_to controller: "products", action: 'show'
  #       end
  #      #↑テーブルの情報元に要修正
  #     end
  #   end

  #   #--------カード削除--------    
  #   def delete
  #     card = current_user.credit_card
  #     if card.blank?
  #       redirect_to action: "new"
  #     else
  #       Payjp.api_key = 'sk_test_0e2eb234eabf724bfaa4e676'
  #       customer = Payjp::Customer.retrieve(card.customer_id)
  #       customer.delete
  #      # pay.jpの方を消去
  #       card.delete
  #      # テーブルにあるcardデータを消去
  #     end  
  #   end


  # before_action :get_user_params, only: [:edit, :confirmation, :show]
  # before_action :get_payjp_info, only: [:new_create, :create, :delete, :show]
#   def new
#     # card = Card.where(user_id: current_user.id)
#     # redirect_to action: "show" if card.exists?
#   end

#   def edit
#   end

#   def create
#     # if params['payjp-token'].blank?
#     #   redirect_to action: "edit", id: current_user.id
#     # else
#     #   customer = Payjp::Customer.create(
#     #   email: current_user.email,
#     #   card: params['payjp-token'],
#     #   metadata: {user_id: current_user.id}
#     #   )
#     #   @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
#     #   if @card.save
#     #     redirect_to action: "show"
#     #   else
#     #     redirect_to action: "edit", id: current_user.id
#     #   end
#     # end
#   end

#   def delete
#     # card = current_user.credit_cards.first
#     # if card.present?
#     #   customer = Payjp::Customer.retrieve(card.customer_id)
#     #   customer.delete
#     #   card.delete
#     # end
#     #   redirect_to action: "confirmation", id: current_user.id
#   end

#   def show
#     # card = current_user.credit_cards.first
#     # if card.present?
#     #   customer = Payjp::Customer.retrieve(card.customer_id)
#     #   @default_card_information = customer.cards.retrieve(card.card_id)
#     # else
#     #   redirect_to action: "confirmation", id: current_user.id
#     # end
#   end

#   def confirmation
#     # card = current_user.credit_cards
#     # redirect_to action: "show" if card.exists?
#   end

#   private

#   def get_payjp_info
#     # if Rails.env == 'development'
#     #   Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
#     # else
#     #   Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
#     # end
#   end
# end