class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook google_oauth2]

        def self.from_omniauth(auth)
          sns = SnsCredential.where(uid: auth["uid"], provider: auth["provider"]).first
          if sns.present?
            user = sns.user
          else
            user = User.where(email: auth["info"]["email"]).first
            if user.present?
              SnsCredential.create(uid: auth["uid"], provider: auth["provider"], user_id: user.id)
              user
            else
              user
            end
          end
        end
end
