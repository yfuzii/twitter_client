class AddAcquiredAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :acquired_at, :datetime
  end
end
