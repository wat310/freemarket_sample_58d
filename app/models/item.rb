class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  has_many :item_images
  has_many :coments

  enum state: [:新品, :目立った傷や汚れなし, :やや傷や汚れあり, :傷や汚れあり, :全体的に状態が悪い]
  enum postage: [:送料込み, :着払い]
  #region(発送元の地域)については考え中
  #shipping_method(配送の方法)も後で
  enum shipping_date: [:one_two, :two_three, :four_seven]

end
