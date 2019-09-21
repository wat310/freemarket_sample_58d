class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook google_oauth2]

        # validates :family_name_kanji, presence: true
        # validates :first_name_kanji, presence: true
        # validates :family_name_kana, presence: true
        # validates :first_name_kana, presence: true
        # validates :nickname, presence: true, uniqueness: true
        # validates :email, presence: true, uniqueness: true
        # validates :password, presence: true, length: { minimum: 7, maximum: 15}
        # validates :number, presence: true, uniqueness: true, length: { minimum: 10}
        # validates :birthday, presence: true
        # validates :postal_code, presence: true
        # validates :prefecture_id, presence: true
        # validates :city, presence: true
        # validates :house_number, presence: true
        # validates :building, presence: true
        # validates :phone_number, presence: true, uniqueness: true

        has_one :credit_card
        has_one :profile
        accepts_nested_attributes_for :profile
        has_one :adress

end
