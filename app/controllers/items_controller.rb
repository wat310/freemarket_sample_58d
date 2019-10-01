class ItemsController < ApplicationController
  require "item.rb"
  before_action :set_item, only: [:show, :edit, :update, :destroy, :buy]
  before_action :set_search, only: [:search]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

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
    if params[:images] == nil # 画像が投稿されない時は出品ページに返す
      redirect_to new_item_path
    elsif params[:images][:image] != nil
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
  end

  #カテゴリーの子と孫はjsonで処理(routes.rbで記述済)
  #親カテゴリー選択後に発生
  def get_category_children
    # 選択された親カテゴリーの子カテゴリーの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_info]}", ancestry: nil).children
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


  def edit
    fee = @item.price * 0.1
    @fee = fee.floor
    @profit = @item.price - @fee

    # 親セレクトボックスの初期値(配列)
    @category_parent_array = ["---"]
    # categoriesテーブルから親カテゴリーのみを抽出、配列に格納
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end

    # itemに紐づいていいる孫カテゴリーの親である子カテゴリが属している子カテゴリーの一覧を配列で取得
    @category_child_array = @item.category.parent.parent.children

    # itemに紐づいていいる孫カテゴリーが属している孫カテゴリーの一覧を配列で取得
    @category_grandchild_array = @item.category.parent.children
  end

  def update
    if params[:images] == nil # 画像に変更を加えていない時は、画像以外のパラメーターを更新する
      @item.update(item_update_params)
    elsif params[:images][:image] != nil
      @item.update(item_params)
      @item.images.destroy_all # 元々の画像を全て削除する
      params[:images][:image].each do |i|
        @item.images.build(image: i, item_id: @item.id)
      end
    end
      if @item.save
        redirect_to action: 'show'
      else
        redirect_to edit_item_path
      end
  end

  def buy
  end

  def show
    @next_item = Item.find_by("id > ?", @item.id)
    @prev_item = Item.where("id < ?", @item.id).first
    @images = @item.images
    @user_item = Item.update_desc.where(user_id: @item.user_id).limit(6)
    @category_item = Item.update_desc.where(category_id: @item.category_id).limit(6)
  end

  def destroy
    if @item.user_id == current_user.id
      @item.destroy
      redirect_to root_path
    end
  end

  def search
    @items = @q.result
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
      images_attributes: [:image]
      )
      .merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_update_params # 画像に変更を加えない時のパラメーター
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
      )
      .merge(user_id: current_user.id)
  end
  def search_params
    params.require(:q).permit(
      :sorts,
      :name_cont,
      :brand_name_cont,
      :price_gteq,
      :price_lteq,
      :state,
      :postage,
      {category_id_in: []},
      {business_status_in: []},


    )
  end
  
  def set_search
    @q = Item.ransack(params[:q])
  end


end