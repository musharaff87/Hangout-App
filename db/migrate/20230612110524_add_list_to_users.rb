class AddListToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :my_friends, :text
  end
end
