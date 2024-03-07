class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({"email" => params["email"]})
    if @user != nil
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome, #{@user["username"]}"
        redirect_to "/places"
      else
        flash["notice"] = "Wrong password :( Please try again!"
        redirect_to "/login"
      end
    else
      flash["notice"] = "Account with this email does not exist :( Please sign up!"
      redirect_to "/users/new"
    end
  end

  def destroy
    flash["notice"] = "Thank you for visiting! Goodbye!"
    session["user_id"] = nil
    redirect_to "/login"
  end
end
  