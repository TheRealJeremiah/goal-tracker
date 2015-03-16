class SessionsController < ApplicationController
  before_action only: [:new, :create] do
    redirect_to user_path(current_user) if !current_user.nil?
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if user.nil?
      flash.now[:errors] = ["Wrong credentials"]
      render :new
    else
      login_user(user)
      redirect_to user_path(user)
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

  def new

  end

  private

end
