class AddDefaultLoginCountToUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :login_count, :integer, default: 0
  end
end
