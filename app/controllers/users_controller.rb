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
  params.require(:user).permit(:name, :email, profiles_attributes:[:family_name_kanji, :first_name_kanji, :family_name_kana, :first_name_kana, :_destroy, :id])
  end
end