class ToppagesController < ApplicationController
  before_action :client_new

  def home
    if current_user
      @user = @client.user
      @tweets = @client.home_timeline(include_entitles: true)
      @followings = followings
    end
  end

  def follow
    @client.follow(params[:screen_name])
    flash[:success] = "@#{params[:screen_name]} をフォローしました。"
    redirect_to root_path
  end

  def unfollow
    @client.unfollow(params[:screen_name])
    flash[:success] = "@#{params[:screen_name]} のフォローを解除しました。"
    redirect_to root_path
  end

  private

    # フォローしているユーザーの screen_name (@以下の部分) を返す
    def followings
      screen_names = []
      @client.friends.attrs[:users].each do |user|
        screen_names << user[:screen_name]
      end
      screen_names
    end
end
