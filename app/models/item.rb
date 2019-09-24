class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :brand, optional: true
  has_many :comments
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images

  enum state: { news: 0, no_dirty: 1, little_dirty: 2, dirty: 3, bad: 4 }
  enum size: { XXS: 0, xs: 1, S: 2, M: 3, L: 4, XL: 5, xxl: 6, xxxl: 7, xxxxl: 8, free: 9 }
  enum postage: { seller: 0, buyer: 1 }
  enum shipping_method: { no_method: 0, mer: 1, yu_m: 2, letter: 3, normal: 4, yamato: 5, yu_pack: 6, c_post: 7, yu_packet: 8 }
  enum shipping_date: { one_two: 0, two_three: 1, four_seven: 2 }
  enum business_status: { sell: 0, negotiation: 1, sale: 2 }

  validates :name, presence: true, length: { in: 1..40 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  validates :explanation, presence: true, length: { in: 1..1000 }
  validates :state, presence: true
  validates :postage, presence: true
  validates :shipping_method, presence: true
  validates :shipping_date, presence: true
  validates :business_status, presence: true
  validates :prefecture_id, presence: true
  validates :category_id, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end