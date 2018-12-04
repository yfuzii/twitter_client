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

    # OAuth認証の設定
    def client_new
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key = Rails.application.secrets.twitter_api_key
        config.consumer_secret = Rails.application.secrets.twitter_api_secret
        config.access_token = session[:oauth_token]
        config.access_token_secret = session[:oauth_token_secret]
      end
    end

    # フォローしているユーザーの screen_name (@以下の部分) を返す
    def followings
      screen_names = []
      @client.friends.attrs[:users].each do |user|
        screen_names << user[:screen_name]
      end
      screen_names
    end
end
