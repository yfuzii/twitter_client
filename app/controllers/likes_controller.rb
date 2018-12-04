class LikesController < ApplicationController
  before_action :client_new, :require_user_logged_in

  def index
    @user = @client.user
    @likes = Like.where(user_id: current_user.id).page(params[:page]).per(10)
  end

  def create
    @like = Like.new(like_params)
    flash[:success] = "Likes にツイートを保存しました。" if @like.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = current_user.likes.find_by(tweet_id: params[:like][:tweet_id])
    flash[:success] = "ツイートの保存を解除しました。" if @like.destroy
    redirect_back(fallback_location: root_path)
  end

  private

    def like_params
      params.require(:like).permit(:tweet_id, :name, :screen_name, :image_url,
        :text, :posted_at, :count_retweets, :count_likes, :user_id)
    end
end
