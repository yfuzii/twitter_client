class ChangeDatatypePostedAtOfLikes < ActiveRecord::Migration[5.2]
  def change
    change_column :likes, :posted_at, :string
  end
end
