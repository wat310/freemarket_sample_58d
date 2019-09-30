class PurchaseController < ApplicationController

# クレジット購入
# TODO:private下でset
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
    @item = Item.find_by(params[:id])
    @images = @item.images

    card = Card.find_by(user_id: current_user.id)
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    customer = Payjp::Customer.retrieve(card.customer_id)
    @default_card_information = customer.cards.retrieve(card.card_id)
  end

  def create
    @item = Item.find_by(params[:id])

    card = Card.find_by(user_id: current_user.id)
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    amount: @item.price,
    customer: card.customer_id,
    currency: 'jpy',
  )

    if @item.update(business_status: 1, buyer_id: current_user.id)
      redirect_to action: 'done'
    else
      flash[:alert] = '購入に失敗しました。'
      redirect_to controller: "items", action: 'show'
    end
  end

# private
# set
# @item = Item.find(params[:id])
# @images = @item.images
# @profile = current_user.profile
# @credit_card = Credit.find_by(user_id: current_user.id)

end