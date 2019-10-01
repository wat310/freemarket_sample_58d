class MypageController < ApplicationController

  before_action :move_to_index
  before_action :card_info

  def index
  end

  def logout
  end

  def identification
  end

  def profile
  end 

  private
  def move_to_index
    redirect_to root_path unless user_signed_in?
  end

  def card_info
    @card = Card.where(user_id: current_user.id)
  end
end