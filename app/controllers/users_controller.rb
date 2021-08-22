class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) 
    @articles = @user.articles
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Sign up successful. Welcome to Alpha Blog, #{@user.username}!"
      redirect_to articles_path 
    else
      render "new"      
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your account information was updated."
      redirect_to articles_path
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end