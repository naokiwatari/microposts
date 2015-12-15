class UsersController < ApplicationController
  def show # 追加
   @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit # 更新
    @user = User.find(user_params)
#    if current_user != @user
#      redirect_to root_path
#    else 
    render 'edit'
  end

  
  def update
    if current_user != @user
      redirect_to root_path
    elsif @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to @user , notice: 'プロフィールを編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :age, 
                                 :password_confirmation)
  end
end