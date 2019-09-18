class ItemsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :edit]

  def index
    # @items = @items.where
  end

  def new
    @item = Item.new
    @item.item_images.build
    # アソシエーションを組んだモデル用にbuildを使用
    # 5.times { @item.item_images.build }

    #セレクトボックスの初期値(配列)
    @category_parent_array = ["---"]
    #categoriesテーブルから親カテゴリーのみを抽出、配列に格納
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def create
    @item = Item.new(item_params)
    # respond_to do |format|
    # binding.pry
      if @item.save
        # params[:item_images][:image].each do |image|
        #   @item.item_images.create(image: image, item_id: @item_id)
        # end
        redirect_to root_path
        # format.html{redirect_to root_path}
      else
        # @item.item_images.build
        # format.html{render action: 'new'}
        redirect_to new_item_path
      end
    # end
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
      :user_id,
      item_images_attributes: {image: []}
      # item_images_attributes: [:image]
      )
      # .merge(user_id: current_user.id)
  end

end