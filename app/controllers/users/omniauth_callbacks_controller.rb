class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google_oauth2)
  end

  def callback_for(provider)
    @omniauth =request.env["omniauth.auth"]
    auth = User.find_oauth(request.env["omniauth.auth"]) #usersモデルのメソッド
    @user = auth[:user]
    @sns = auth[:sns]

    if @user.persisted? #userが存在したら
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else #userが存在しなかったら
      session[:provider] = @sns[:provider]
      session[:uid] = @sns[:uid]
      render template: "signup/step1" #redirect_to だと更新してしまうのでrenderで
    end
  end
  
  def failure
    redirect_to root_path and return
  end

end