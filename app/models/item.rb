class Item < ApplicationRecord
  # belongs_to :user
  belongs_to :category
  belongs_to :brand
  has_many :coments
  has_many :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images

  enum state: [:news, :no_dirty, :little_dirty, :dirty, :bad]

  enum size: [:XXS, :xs, :S, :M, :L, :XL, :xxl, :xxxl, :xxxxl, :free]

  enum postage: [:seller, :buyer]
  enum shipping_method: [:no_method, :mer, :yu_m, :letter, :normal, :yamato, :yu_pack, :c_post, :yu_packet]
  enum shipping_date: [:one_two, :two_three, :four_seven]

  # validates :name, presence: true, length: { in: 1..40 }
  # validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  # validates :explanation, presence: true, length: { in: 1..1000 }
  # validates :state, presence: true
  # validates :postage, presence: true
  # validates :shipping_method, presence: true
  # validates :shipping_date, presence: true
  # validates :business_status, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

end
