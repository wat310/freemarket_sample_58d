class ItemsController < ApplicationController
  require "item.rb"
  # before_action :authenticate_user!, only: [:new, :edit]

  def index

  ladies_array = []
  mens_array = []
  ladies = Category.where(ancestry: 1)
  mens = Category.where(ancestry: 2)
  ladies.each do |lady|
    ladies_array << lady.child_ids
  end
  @lady_id = ladies_array.flatten

  mens.each do |man|
    mens_array << man.child_ids
  end
  @man_id = mens_array.flatten

    @ladies =Item.update_desc.limit(10).where(category_id:@lady_id )
    @mens =Item.update_desc.limit(10).where(category_id:@man_id )
    # TODO ブランド変数の作成
  end

  def new
    @item = Item.new
    @item.images.build

    #セレクトボックスの初期値(配列)
    @category_parent_array = ["---"]
    #categoriesテーブルから親カテゴリーのみを抽出、配列に格納
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def create
    @item = Item.new(item_params)
    # binding.pry
    params[:images][:image].each do |i|
      #createだとエラーが出た
      @item.images.build(image: i, item_id: @item.id)
    end
      if @item.save
        redirect_to root_path
      else
        redirect_to new_item_path
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

  def show
    @item = Item.find(params[:id])
    @next_item = Item.where("id > ?", @item.id).order("id ASC").first
    @prev_item = Item.where("id < ?", @item.id).order("id DESC").first
    @images = @item.images
    @user_item = Item.update_desc.where(user_id: @item.user_id).limit(6)
    @category_item = Item.update_desc.where(category_id: @item.category_id).limit(6)

  end

  private

  def item_params
    params.require(:item).permit(
      :name,
      :price,
      :explanation,
      :category_id,
      :brand_id,
      :size,
      :state,
      :postage,
      :shipping_method,
      :prefecture_id,
      :shipping_date,
      :business_status,
      :user_id, #このuser_idは仮置き、あとで消すこと!!、hamlにも仮のuser_idの記載あり!!
      images_attributes: [:image]
      )
      # .merge(user_id: current_user.id)
  end



  def card
  end

end