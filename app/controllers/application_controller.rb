class ApplicationController < ActionController::Base
  include SessionsHelper
  include LikesHelper

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

    def require_user_logged_in
      redirect_to root_path unless current_user
    end
end
