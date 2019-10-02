class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

        validates :nickname, presence: true, length: { maximum: 20 }
        VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
        validates :family_name_kanji, presence: true, length: { maximum: 20 }
        validates :first_name_kanji, presence: true, length: { maximum: 20 }
        validates :family_name_kana, presence: true, length: { maximum: 20 }
        validates :first_name_kana, presence: true, length: { maximum: 20 }
        validates :password, presence: true, length: { minimum: 7, maximum: 15}
        validates :phone_number, presence: true
        validates :birth_year, presence: true
        validates :birth_month, presence: true
        validates :birth_day, presence: true
        validates :postal_code, presence: true
        validates :prefecture_id, presence: true
        validates :city, presence: true
        validates :house_number, presence: true

        # SNSログイン機能。facebookかgoogleからユーザー情報を引っ張り出してreturnする。
        # このときSNScredentialsテーブルにはuidとproviderを保存するが、User情報は保存しない。
         def self.find_oauth(auth)
          uid = auth.uid
          provider = auth.provider
          snscredential = SnsCredential.where(uid: uid, provider: provider).first
          if snscredential.present? #sns登録のみ完了してるユーザー
            user = User.where(id: snscredential.user_id).first
            unless user.present? #ユーザーが存在しないなら
              user = User.new(
                nickname: auth.info.name,
                email: auth.info.email,
              )
            end
            sns = snscredential
          else #sns登録 未
            user = User.where(email: auth.info.email).first
          if user.present? #会員登録 済
            else #会員登録 未
              user = User.new(
                nickname: auth.info.name,
                email: auth.info.email,
              )
              sns = SnsCredential.new(
                uid: uid,
                provider: provider,
              )
            end
          end
          return {  user: user , sns: sns } # hashでsnsのidを返り値として保持しておく
        end

        extend ActiveHash::Associations::ActiveRecordExtensions
        belongs_to_active_hash :prefecture
        
  has_many :items, dependent: :destroy
  has_many :sns_credentials, dependent: :destroy
  has_one :card

end
