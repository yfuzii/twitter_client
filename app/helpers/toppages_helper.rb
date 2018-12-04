module ToppagesHelper
  # ログインユーザーが other_user をフォローしているか判定
  def following?(other_user)
    @followings.include?(other_user[:screen_name])
  end
end