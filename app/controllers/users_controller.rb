class UsersController < ApplicationController

def index
end

def new
end

def show
end

def create
end

def show
end

def edit
end

def update

end

private
def user_params
  params.require(:user).permit(:name, :email, :family_name_kanji, :first_name_kanji, :family_name_kana, :first_name_kana, :birth_year, :birth_month, :birth_day, :phone_number, :postal_code, :prefecture_id, :city, :house_number, :building, :credit_cards_number, :credit_cards_limit_year, :credit_cards_limit_month, :security_code)
end
end