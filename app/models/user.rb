class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

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

        

        # TODO: 後でバリデーション機能を追加・修正予定。（SNS認証機能追加後）

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

  has_many :items, dependent: :destroy
  has_many :sns_credentials, dependent: :destroy

end
