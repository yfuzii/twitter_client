module LikesHelper
  # ログインユーザーが tweet を保存しているか判定
  def saving?(tweet)
    like_tweet_ids = []
    if current_user.likes
      current_user.likes.each do |like|
        like_tweet_ids << like.tweet_id.to_i
      end
    end
    like_tweet_ids.include?(tweet.id)
  end
end
