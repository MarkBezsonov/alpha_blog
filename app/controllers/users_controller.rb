class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    @articles = @user.articles.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def index
    @users = User.order(@articles).paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your profile information was updated."
      redirect_to @user
    else
      render "edit"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Sign up successful. Welcome to Alpha Blog, #{@user.username}!"
      redirect_to articles_path 
    else
      render "new"      
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "The profile and all of its associated articles have been deleted. Sorry to see you go!"
    redirect_to articles_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id]) 
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own profile."
      redirect_to @user
    end
  end
end