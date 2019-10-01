class Users::RegistrationsController < Devise::RegistrationsController


  def create
     if params[:user][:password] == "" #sns登録なら
       params[:user][:password] = "Devise.friendly_token.first(6)" #deviseのパスワード自動生成機能を使用
       params[:user][:password_confirmation] = "Devise.friendly_token.first(6)"
       super
       sns = SnsCredential.update(user_id:  @user.id)
     else #email登録なら
       super
     end
   end
end