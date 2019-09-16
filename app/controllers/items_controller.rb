class ItemsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :edit]

  def index
    # @items = @items.where
  end

  def new
    @item = Item.new
    @image = Item_images.new
    #セレクトボックスの初期値(配列)
    @category_parent_array = ["---"]
    #categoriesテーブルから親カテゴリーのみを抽出、配列に格納
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  #カテゴリーの子と孫はjsonで処理(routes.rbで記述済)
  #親カテゴリー選択後に発生
  def get_category_children
    # 選択された親カテゴリーの子カテゴリーの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  #子カテゴリー選択後に発生
  def get_category_grandchildren
    # 選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  #ブランドの取得
  def brand_search
    @brands = Brand.where('name LIKE(?)', "%#{params[:keyword]}%")
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
    params.require(:item).permit(:name, :price, :explanation, :user_id, :category_id)
  end

end