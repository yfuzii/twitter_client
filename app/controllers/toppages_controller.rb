class ToppagesController < ApplicationController
  before_action :client_new

  def home
    if current_user
      @user = @client.user
      @tweets = @client.home_timeline(include_entitles: true)
    end
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
end
