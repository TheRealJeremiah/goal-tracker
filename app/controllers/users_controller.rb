class UsersController < ApplicationController
  def new
    render :new
  end

  def show
    @user = User.find(params[:id])
    @goals = @user.goals
    @comments = @user.user_comments
    render :show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
