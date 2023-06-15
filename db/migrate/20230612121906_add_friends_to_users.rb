class AddFriendsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :friends, :json
  end
end
