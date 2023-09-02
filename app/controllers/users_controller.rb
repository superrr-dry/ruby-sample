class UsersController < ApplicationController
  # user一覧画面表示
  def index
    @users = User.all
  end
  # user作成画面表示
  def new
    @user = User.new
  end
  # user作成処理
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path and return
    end

    flash[:errors] = @user.errors.full_messages
    redirect_to action: :new
  end
  # user画面表示
  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end
end