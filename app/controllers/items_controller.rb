class ItemsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :edit] # TODO これはあとで使う予定
  before_action :set_item, only: [:show, :edit, :update, :destroy, :buy]

  def index
    # @items = @items.where
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
    # if params[:images][:image].count != 0
    params[:images][:image].each do |i|
      #createだとエラーが出た
      @item.images.build(image: i, item_id: @item.id)
    end
    # end
      if @item.save
        binding.pry
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

  def edit
    # セレクトボックスの初期値(配列)
    @category_parent_array = []
    @category_child_array = []
    @category_grandchild_array = []

    # itemに紐づいていいる孫カテゴリの親である子カテゴリが属している子カテゴリの一覧を配列で取得
    child_category_array_origin = @item.category.parent.parent.children

    # itemに紐づいていいる孫カテゴリが属している孫カテゴリの一覧を配列で取得
    grandchild_category_array_origin = @item.category.parent.children

    # categoriesテーブルから親カテゴリーのみを抽出、配列に格納
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end

    # 子カテゴリの配列を新規作成(名前を表示させるために)
    child_category_array_origin.each do |child|
      @category_child_array << child.name
    end

    # 孫カテゴリの配列を新規作成(名前を表示させるために)
    grandchild_category_array_origin.each do |grandchild|
      @category_grandchild_array << grandchild.name
    end

  end

  def update
  end

  def show
  end

  def buy
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
      :user_id, # TODO このuser_idは仮置き、あとで消すこと!!、hamlにも仮のuser_idの記載あり!!
      images_attributes: [:image]
      )
      # .merge(user_id: current_user.id) #TODO これはあとで使う予定
  end

  def set_item
    @item = Item.find(params[:id])
  end

end