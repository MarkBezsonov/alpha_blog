class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "You are now logged in. Welcome back!"
      redirect_to user
    else
      flash.now[:alert] = "Your credentials were incorrect. Please try again."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You are now logged out. Come back soon!"
    redirect_to root_path
  end
end