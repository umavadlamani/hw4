class UsersController < ApplicationController
  def new
  end

  def create
    if User.find_by({"email" => params["email"]}) == nil
      @user = User.new
      @user["username"] = params["username"]
      @user["email"] = params["email"]
      @user["password"] = BCrypt::Password.create(params["password"])
      @user.save
      redirect_to "/places"
    else
      flash["notice"] = "Account with this email already exists. Please log in!"
      redirect_to "/login"
    end     
  end
end
