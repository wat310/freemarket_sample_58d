class CardController < ApplicationController
  # WIP:クレジットカード実装中

  require "payjp"
  def new
    card = Card.where(user_id: current_user.id)
    redirect_to action: "show" if card.exists?
  end

  def step4
  end

  #----カード作成(payjpとCardのデータベース作成)
  def pay
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      # binding.pry
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

  #----カード情報(Cardのデータpayjpに送り情報を取り出す)
  def show
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end
  
  #----カード削除
  def delete
    card = Card.find_by(user_id: current_user.id)
    # card = current_user.credit_card
    if card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete #payjpから削除
      card.delete #テーブルから削除
    end
      redirect_to '/card/new'
    # redirect_to action: "new"
  end

end

#   private
#   def get_payjp_info
#     # if Rails.env == 'development'
#     #   Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
#     # else
#     #   Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
#     # end
#   end
# end