class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook google_oauth2]

         def self.from_omniauth(auth)
          where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.email = auth.info.email
            user.password = Devise.friendly_token[0,20]
          end
        end



        # validates :nickname,
        #   presence: true,
        #   length: { maximum: 20 }
        # validates :email,
        #   presence: true,
        #   uniqueness: { message: "メールアドレスに誤りがあります。ご確認いただき、正しく変更してください。" },
        #   format: { with: /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*[a-zA-Z]+\z/, allow_blank: true, message: "フォーマットが不適切です" }
        # validates :family_name_kanji,
        #   presence: true,
        #   length: { maximum: 35 }
        # validates :first_name_kanji,
        #   presence: true,
        #   length: { maximum: 35 }
        # validates :family_name_kana,
        #   presence: true,
        #   length: { maximum: 35 }
        # validates :first_name_kana,
        #   presence: true,
        #   length: { maximum: 35 }
        # validates :password,
        #   presence: true,
        #   length: { minimum: 7, maximum: 15}
        # validates :phone_number,
        #   length: { maximum: 11, message: "11文字で入力して下さい" },
        #   uniqueness: { message: "この電話番号は既に登録されています。" },
        #   format: { with: /\A\d{11}\z/, message: "この電話番号は登録できません" }
        # validates :birth_year,
        #   presence: true
        # validates :birth_month,
        #   presence: true
        # validates :birth_day,
        #   presence: true
        # validates :postal_code,
        #   presence: true
        # validates :prefecture_id,
        #   presence: true
        # validates :city,
        #   presence: true
        # validates :house_number,
        #   presence: true
        # validates :building,
        #   presence: true


        extend ActiveHash::Associations::ActiveRecordExtensions
        belongs_to_active_hash :prefecture
        


        #  :recoverable, :rememberable, :validatable

  has_many :items

end
