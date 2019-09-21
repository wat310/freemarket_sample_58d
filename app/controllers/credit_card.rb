class CardController < ApplicationController

  require "payjp"

  def new
    card = Card.new
    @user = current_user

  end

  def delete 
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    customer = Payjp::Customer.retrieve(card.customer_id)
    customer.delete
    card.delete
    redirect_to action: "new"
  end

  def show 
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
       redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      description: '登録テスト', 
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      ) 
      @card = Card.new(
        user_id: current_user.id, 
        customer_id: customer.id, 
        card_id: customer.default_card,
      )
    if @card.save
      redirect_to card_registration_item_path(current_user)
      else
        redirect_to action: "show"
      end
    end
  end


  private
  def card_params
    params.require(:card).permit(
        :user_id,
        :customer_id,
        :card_id,
   　　 )
  end
end