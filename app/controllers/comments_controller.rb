class CommentsController < ApplicationController
  def create
    if params[:user_id]
      user = User.find(params[:user_id])
      @comment = user.comments.new(comment_params)
      @comment.user_id = current_user.id
      if @comment.save
        redirect_to user_url(user)
      else
        flash[:errors] = @comment.errors.full_messages
        redirect_to user_url(user)
      end
    elsif params[:goal_id]
      goal = Goal.find(params[:goal_id])
      @comment = goal.comments.new(comment_params)
      if @comment.save
        redirect_to goal_url(goal)
      else
        flash[:errors] = @comment.errors.full_messages
        redirect_to goal_url(goal)
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
