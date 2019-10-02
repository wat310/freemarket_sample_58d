class PurchaseController < ApplicationController
# クレジット購入

  require 'payjp'
  before_action :get_payjp_info
  before_action :get_items_info, only: [:done, :show]

  def show
    # if 
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

  def update
    @item = Item.find(params[:id])
    card = Card.find_by(user_id: current_user.id)
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    amount: @item.price,
    customer: card.customer_id,
    currency: 'jpy',
  )

    if @item.update(business_status: 2, buyer_id: current_user.id)
      redirect_to action: 'done'
    else
      flash[:alert] = '購入に失敗しました。'
      redirect_to controller: "items", action: 'show'
    end

  end

  private
  def get_payjp_info
    if Rails.env == 'development'
       Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    else
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
    end
  end

  def get_items_info
    @item = Item.find(params[:id])
    @images = @item.images
  end
end