class Profile < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
        #  validates :family_name_kanji, presence: true
        #  validates :first_name_kanji, presence: true
        #  validates :family_name_kana, presence: true
        #  validates :first_name_kana, presence: true
        #  validates :birthday, presence: true

         belongs_to :user
end
