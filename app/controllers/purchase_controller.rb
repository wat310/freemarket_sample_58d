class PurchaseController < ApplicationController

# クレジット購入
# TODO:ルーティング要修正。下記、商品購入ページ実装前のため仮置きページに偏移する仕様。
  require 'payjp'
  def index
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def pay
    card = Card.find_by(user_id: current_user.id)
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    amount: 13500, #TODO:支払金額itemテーブルと紐づけ
    customer: card.customer_id,
    currency: 'jpy',
  )
  redirect_to action: 'done' #完了画面に移動
  end
end