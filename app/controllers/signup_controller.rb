class SignupController < ApplicationController

  private
# 許可するキーを設定
  def user_params
    params.require(:user).permit(
      :nickname, 
      :email, 
      :encrypted_password, 
      :reset_password, 
      :last_name, 
      :first_name, 
      :last_name_kana, 
      :first_name_kana, 
    )
  end


  def step1
    @user = User.new # 新規インスタンス作成
  end

  def step2
    # step1で入力された値をsessionに保存
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:encrypted_password] = user_params[:encrypted_password]
    session[:reset_password] = user_params[:reset_password]
    @user = User.new # 新規インスタンス作成
  end

  
  def step3
    # step2で入力された値をsessionに保存
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    @user = User.new # 新規インスタンス作成
  end

  def step4
    # step3で入力された値をsessionに保存
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    @user = User.new # 新規インスタンス作成
    @address = Address.new
  end

  def step5
    # step4で入力された値をsessionに保存
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    @user = User.new # 新規インスタンス作成

  end

  def step6
    # step5で入力された値をsessionに保存
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    @user = User.new # 新規インスタンス作成
  end



  # if @user.save
  #   # ログインするための情報を保管
  #         session[:id] = @user.id
  #         redirect_to step6_signup_index_path
  #       else
  #         render '/signup/registration'
  #       end

  #       def step6
  #         sign_in User.find(session[:id]) unless user_signed_in?
  #       end

end
