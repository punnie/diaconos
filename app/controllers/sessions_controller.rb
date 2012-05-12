class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.authenticate!(params[:user])

    if(@user)
      session[:current_user] = @user.id
      redirect_to root_url, notice: "Successfully logged in."
    else
      redirect_to root_url, notice: "Successfully failed to log in, dumbass."
    end
  end

  def destroy
    session.delete(:current_user)
    redirect_to root_url
  end
end
