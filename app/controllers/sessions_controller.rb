class SessionsController < ApplicationController
  # Login
  def create
    auth = request.env['omniauth.auth']
    user = User.find_or_create_from_auth_hash(auth)
    session[:user_id] = user.id
    user.increment!(:login_count)
    flash[:success] = 'ログインしました。'
    redirect_to root_path
  end

  # Logout
  def destroy
    reset_session
    flash[:success] = 'ログアウトしました。'
    redirect_to root_path
  end
end
