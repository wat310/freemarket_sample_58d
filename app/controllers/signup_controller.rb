class SignupController < ApplicationController


  def step1
    @user = User.new # 新規インスタンス作成
    @user.build_profile
  end

  def step2
    # step1で入力された値をsessionに保存
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:family_name_kanji] = profile_params[:family_name_kanji]
    session[:first_name_kanji] = profile_params[:first_name_kanji]
    session[:family_name_kana] = profile_params[:family_name_kana]
    session[:first_name_kana] = profile_params[:first_name_kana]
    # session[:birthday] = profile_params[:birthday]
    @user = User.new # 新規インスタンス作成
    @user.build_profile
  end
  
  # def step3
  #   # step2で入力された値をsessionに保存
  #   session[:phone_number] = profile_params[:phone_number]
  #   @user = User.new # 新規インスタンス作成
  # end

  # def step4
  #   # # step3で入力された値をsessionに保存
  #   session[:phone_number] = profile_params[:phone_number]
  #   @user = User.new # 新規インスタンス作成
  # end

  # def step5
  #   # step4で入力された値をsessionに保存
  #   session[:family_name_kanji] = profile_params[:family_name_kanji]
  #   session[:first_name_kanji] = profile_params[:first_name_kanji]
  #   session[:family_name_kana] = profile_params[:family_name_kana]
  #   session[:first_name_kana] = profile_params[:first_name_kana]
  #   session[:postal_code] = address_params[:postal_code]
  #   session[:prefecture_id] = address_params[:prefecture_id]
  #   session[:city] = address_params[:city]
  #   session[:house_number] = address_params[:house_number]
  #   session[:building] = address_params[:building]
  #   session[:phone_number] = profile_params[:phone_number]
  #   @user = User.new # 新規インスタンス作成
  # end

  # def step6
  #   # step5で入力された値をsessionに保存
  #   session[:number] = credit_cards_params[:number]
  #   session[:limit_year] = credit_cards_params[:limit_year]
  #   session[:limit_month] = credit_cards_params[:limit_month]
  #   session[:user_id] = credit_cards_params[:user_id]
  # end

  def create
    @user = User.new(
      nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      family_name_kanji: session[:family_name_kanji], 
      first_name_kanji: session[:first_name_kanji], 
      family_name_kana: session[:family_name_kana], 
      first_name_kana: session[:first_name_kana], 
      # birthday: session[:birthday],
      # postal_code: session[:postal_code],
      # prefecture_id: session[:prefecture_id],
      # city: session[:city],
      # house_number: session[:house_number],
      # building: session[:building],
      # phone_number: params[:user][:profile][:phone_number],
      # phone_number: params[:phone_number],
      # limit_year: session[:limit_year],
      # limit_month: session[:limit_month],
      # user_id: session[:user_id],
    )
    # @profile = Profile.new(
    # phone_number: params[:phone_number]
    # )
    @profile = Profile.new(
      family_name_kanji:params[:family_name_kanji], 
      first_name_kanji:params[:first_name_kanji], 
      family_name_kana:params[:family_name_kana], 
      first_name_kana:params[:first_name_kana]
    )
    if @user.save
    # ログインするための情報を保管
      session[:id] = @user.id
      redirect_to signup_index_path
    else
      render '/signup/step1'
    end
  end

  def step6
    sign_in User.find(session[:id]) unless user_signed_in?
  end



  private
    def user_params
      params.require(:user).permit(
        :nickname, 
        :email, 
        :password,
        :password_confirmation,
        profiles_attributes:[:family_name_kanji, :first_name_kanji, :family_name_kana, :first_name_kana, :_destroy, :id])
    end

  # def profile_params
  #   params.require(:profile).permit(
  #     :family_name_kanji, 
  #     :first_name_kanji, 
  #     :family_name_kana, 
  #     :first_name_kana,
  #     :birthday,
  #     :phone_number,
  #   )
  # end

  # def credit_card_params
  #   params.require(:credit_card).permit(
  #     :number, 
  #     :limit_year, 
  #     :limit_month, 
  #     :security_code,
  #     :user_id,
  #   )
  # end

  # def address
  #   params.require(:address).permit(
  #     :postal_code, 
  #     :prefecture_id, 
  #     :city,
  #     :house_number,
  #     :building,
  #     :user_id,
  #   )
  # end


end
