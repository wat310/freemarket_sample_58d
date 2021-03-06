class SignupController < ApplicationController


  def step1
    @user = User.new # 新規インスタンス作成
  end

  def step2
    # step1で入力された値をsessionに保存
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:family_name_kanji] = user_params[:family_name_kanji]
    session[:first_name_kanji] = user_params[:first_name_kanji]
    session[:family_name_kana] = user_params[:family_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:birth_year] = user_params[:birth_year]
    session[:birth_month] = user_params[:birth_month]
    session[:birth_day] = user_params[:birth_day]
    @user = User.new # 新規インスタンス作成
  end

  def step3
    # step2で入力された値をsessionに保存
    session[:phone_number] = user_params[:phone_number]
    @user = User.new # 新規インスタンス作成
  end

  def step4
    # step3で入力された値をsessionに保存
    user_params[:shipping_family_name_kanji]
    user_params[:shipping_first_name_kanji]
    user_params[:shipping_family_name_kana]
    user_params[:shipping_first_name_kana]

    user_params[:postal_code]
    user_params[:prefecture_id]
    user_params[:city]
    user_params[:house_number]
    user_params[:building]
    session[:phone_number] = user_params[:phone_number]
    @user = User.new # 新規インスタンス作成
  end

  def step5
    # message: クレジットカード登録で使用する可能性あり
    # step4で入力された値をsessionに保存
    # credit_card_params[:number]
    # credit_card_params[:limit_year]
    # credit_card_params[:limit_month]
    # credit_card_params[:security_code]
  end
  
  def create
    if session[:uid].present? && session[:provider].present?
      password = Devise.friendly_token.first(7)
      @user = User.create(
      nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      family_name_kanji: session[:family_name_kanji],
      first_name_kanji: session[:first_name_kanji],
      family_name_kana: session[:family_name_kana],
      first_name_kana: session[:first_name_kana],
      shipping_family_name_kanji: user_params[:shipping_family_name_kanji],
      shipping_first_name_kanji: user_params[:shipping_first_name_kanji],
      shipping_family_name_kana: user_params[:shipping_family_name_kana],
      shipping_first_name_kana: suser_params[:shipping_first_name_kana],
      birth_year: session[:birth_year],
      birth_month: session[:birth_month],
      birth_day: session[:birth_day],
      phone_number: session[:phone_number],
      postal_code: user_params[:postal_code],
      prefecture_id: user_params[:prefecture_id],
      city: user_params[:city],
      house_number: user_params[:house_number],
      building: user_params[:building],
      )
      @sns = SnsCredential.create(
        uid: session[:uid],
        provider: session[:provider],
        user_id: @user.id
      )
    else
      @user = User.new(
        nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
        email: session[:email],
        password: session[:password],
        family_name_kanji: session[:family_name_kanji],
        first_name_kanji: session[:first_name_kanji],
        family_name_kana: session[:family_name_kana],
        first_name_kana: session[:first_name_kana],
        shipping_family_name_kanji: user_params[:shipping_family_name_kanji],
        shipping_first_name_kanji: user_params[:shipping_first_name_kanji],
        shipping_family_name_kana: user_params[:shipping_family_name_kana],
        shipping_first_name_kana: user_params[:shipping_first_name_kana],
        birth_year: session[:birth_year],
        birth_month: session[:birth_month],
        birth_day: session[:birth_day],
        phone_number: session[:phone_number],
        postal_code: user_params[:postal_code],
        prefecture_id: user_params[:prefecture_id],
        city: user_params[:city],
        house_number: user_params[:house_number],
        building: user_params[:building],
        )
      end

      # クレジットカード登録で使用する可能性あり
      # number: credit_card_params[:number],
      # limit_year: credit_card_params[:limit_year],
      # limit_month: credit_card_params[:limit_month],
      # security_code: credit_card_params[:security_code],

    if @user.save
    # ログインするための情報を保管
      session[:id] = @user.id
      redirect_to  "/signup/step5"
    else
      render '/signup/step1'
    end
  end

  def step5
    sign_in User.find(session[:id]) unless user_signed_in?
end
  
  private
    def user_params
      params.require(:user).permit(
        :nickname,
        :email,
        :password,
        :password_confirmation,
        :birth_year,
        :birth_month,
        :birth_day,
        :family_name_kanji,
        :first_name_kanji,
        :family_name_kana,
        :first_name_kana,
        :phone_number,
        :shipping_family_name_kanji,
        :shipping_first_name_kanji,
        :shipping_family_name_kana,
        :shipping_first_name_kana,
        :postal_code,
        :prefecture_id,
        :city,
        :house_number,
        :building,
        # クレジットカード登録で使用する可能性あり
        # :number,
        # :limit_year,
        # :limit_month,
        # :security_code,
      )
    end
end