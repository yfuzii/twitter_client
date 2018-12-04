class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.string :tweet_id
      t.string :name
      t.string :screen_name
      t.string :image_url
      t.text :text
      t.time :posted_at
      t.integer :count_retweets
      t.integer :count_likes
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
