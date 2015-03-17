class GoalsController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_creator, only: [:edit, :update, :destroy]
  before_action :validate_privacy, only: [:show]

  def new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_path(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def show
    @goal = Goal.find(params[:id])
    @comments = @goal.goal_comments
    render :show
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    Goal.destroy(params[:id])
    redirect_to user_path(@goal.user)
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :content, :privacy)
  end

  def ensure_logged_in
    redirect_to new_session_path if current_user.nil?
  end

  def validate_privacy
    goal = Goal.find(params[:id])
    user = goal.user
    # unless (user.id == current_user.id) && (goal.privacy != "private")
    if goal.privacy == "private" && goal.user_id != current_user.id
      redirect_to user_path(user)
    end
  end

  def ensure_creator
    goal = Goal.find(params[:id])
    redirect_to goal_url(goal) unless goal.user_id == current_user.id
  end
end
