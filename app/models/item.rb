class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  has_many :item_images
  has_many :coments

  enum state: [:新品, :目立った傷や汚れなし, :やや傷や汚れあり, :傷や汚れあり, :全体的に状態が悪い]
  enum size: [:XXS, :xs, :S, :M, :L, :XL, :xxl, :xxxl, :xxxxl, :free]
  enum postage: [:seller, :buyer]
  enum shipping_method: [:no_method, :mer, :yu_m, :letter, :normal, :yamato, :yu_pack, :c_post, :yu_packet]
  enum shipping_date: [:one_two, :two_three, :four_seven]

  validates :name, presence: true
  validates :price, presence: true
  validates :explanation, presence: true
  validates :state, presence: true
  validates :postage, presence: true
  validates :shipping_method, presence: true
  validates :shipping_date, presence: true
  validates :business_status, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

end
