class ApplicationController < ActionController::Base
  # Basic認証
  before_action :basic_auth, if: :production?
  before_action :set_search
  protect_from_forgery with: :null_session
  
  # before_action :authenticate_user!  # ログイン済ユーザーのみにアクセスを許可
  

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  # Basic認証
  private
  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
  def set_search
    @q = Item.ransack(params[:q])
    @keyword = :name_or_explanation_or_brand_name_or_category_name__cont
    # @keyword = :name_or_explanation_or_brand_name_or_category_name_cont
    # @cat = []
    # category = Category.all
    # category.each do |c|
    #   @cat << c.name
    # end
  end
end