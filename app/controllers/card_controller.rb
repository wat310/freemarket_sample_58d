class CardController < ApplicationController
#クレジット登録・一覧・削除
#TODO:新規登録画面での登録

  require "payjp"
  before_action :get_payjp_info

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to action: "show" if card.exists?
  end

  def step4
  end

  def create
    get_payjp_info
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to card_path(@card)
      else
        redirect_to action: "create"
      end
    end
  end

  def show
    @card = Card.find_by(user_id: current_user.id)
    if @card.blank?
      redirect_to action: "new" 
    else
      get_payjp_info
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end
  
  def destroy
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to action: "new"
    else
      get_payjp_info
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete #payjpから削除
      card.delete #テーブルから削除
    end
      redirect_to mypage_index_path
  end

  private
  def get_payjp_info
    if Rails.env == 'development'
       Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    else
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
    end
  end
end
