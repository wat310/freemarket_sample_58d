class UsersController < ApplicationController

def index
end

def new
end

def create
end

def show
end

def edit
end

def update

end

def logout
end

def identification
end

def card
end


private

def user_params
  params.require(:user).permit(:name, :email)
end
end