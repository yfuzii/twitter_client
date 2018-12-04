class ToppagesController < ApplicationController
  before_action :client_new

  def home
    if current_user
      @user = @client.user
      @all_tweets = @client.home_timeline(include_entitles: true)
      @new_tweets = new_tweets
      @tweets = @all_tweets - @new_tweets
      @followings = followings
      update_acquisition_time
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

    # タイムラインを最後に取得した時刻を記録する
    def update_acquisition_time
      user = User.find(current_user.id)
      user.update(acquired_at: Time.now)
    end

    # 新着ツイートを返す
    def new_tweets
      new_tweets = []
      @all_tweets.each do |tweet|
        new_tweets << tweet if current_user.acquired_at.to_time < tweet[:created_at]
      end
      new_tweets
    end
end
