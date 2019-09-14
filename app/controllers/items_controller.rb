  class ItemsController < ApplicationController
    # before_action :authenticate_user!, only: [:new, :edit]

  def index
    # @items = @items.where
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    # if
    #   redirect_to root_path
    # else
    #   redirect_to new_item_path
    # end

  end

  private
  def item_params
    # サイズによって条件分岐必要？
    # params.require(:item).permit(:name, :price, :explanation, :user_id, :category_id)
  end

end