class UserCommentsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @comment = @user.user_comments.new(user_comment_params)
    if @comment.save
      redirect_to user_url(@user)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to user_url(@user)
    end
  end

  private

  def user_comment_params
    params.require(:user_comment).permit(:body)
  end
end
