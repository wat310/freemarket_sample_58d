class UsersController < ApplicationController

def index
end

def new
end

def show
end

def logout
end

def create
end

private
def user_params
  params.require(:user).permit(:name, :email, :password, :family_name_kanji, :first_name_kanji, :family_name_kana, :first_name_kana, :birth_year, :birth_month, :birth_day, :phone_number, :postal_code, :prefecture_id, :city, :house_number, :building, :security_code, :shipping_family_name_kanji, :shipping_first_name_kanji, :shipping_family_name_kana, :shipping_first_name_kana)
end
end