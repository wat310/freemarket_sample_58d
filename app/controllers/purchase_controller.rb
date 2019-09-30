class PurchaseController < ApplicationController

# クレジット購入
# TODO:itemsのshowルーティング要修正
  require 'payjp'

  def show
    @item = Item.find(params[:id])
    @images = @item.images

    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def done
    card = Card.find_by(user_id: current_user.id)
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    customer = Payjp::Customer.retrieve(card.customer_id)
    @default_card_information = customer.cards.retrieve(card.card_id)
  end

  def pay
    @item = Item.find(params[:id])

    card = Card.find_by(user_id: current_user.id)
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    amount: 13500, #TODO:支払金額itemテーブルと紐づけ
    customer: card.customer_id,
    currency: 'jpy',
  )
  redirect_to action: 'done'
  end


# private
# set
# @item = Item.find(params[:id])
# @images = @item.images
# @profile = current_user.profile
# @credit_card = Credit.find_by(user_id: current_user.id)

end