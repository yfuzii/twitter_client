module SessionsHelper
  # ログインしているユーザを返す
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # 初回ログインの判定
  def first_login?
    current_user.login_count <= 1
  end
end
