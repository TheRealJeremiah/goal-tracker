class GoalCommentsController < ApplicationController
  def create
    @goal = Goal.find(params[:goal_id])
    @comment = @goal.goal_comments.new(goal_comment_params)
    if @comment.save
      redirect_to goal_url(@goal)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to goal_url(@goal)
    end
  end

  private

  def goal_comment_params
    params.require(:goal_comment).permit(:body)
  end
end
