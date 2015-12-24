class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :followings, :followers]
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show 
   @microposts = @user.microposts.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Microposts!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit 
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def followings
    @title = "Followings"
    if @users = @user.following_users.order(created_at: :desc)
      render 'show_follow'
    else
      redirect_to root_path
    end
  end

  def followers
    @title = "Followers"
    if @users = @user.follower_users.order(created_at: :desc)
      render 'show_follow'
    else
      redirect_to root_path
    end
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def signed_in_user
    redirect_to signin_url, notice: "Please Sign in" unless logged_in?
  end

  def correct_user
    # リダイレクトは root_path ではなく root_url を使う
    redirect_to root_url, alsert: "Unauthorized Access" unless current_user == @user
  end
end
