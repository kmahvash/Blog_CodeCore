class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "You are signed in."
    else
      render :new, alert: "Wrong Credentials!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You have signed out."
  end

end
