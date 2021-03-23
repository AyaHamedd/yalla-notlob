class RenameUsersIdToUserIdInOrders < ActiveRecord::Migration[6.1]
  def self.up
    rename_column :orders, :users_id, :user_id
  end
end
