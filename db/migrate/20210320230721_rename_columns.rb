class RenameColumns < ActiveRecord::Migration[6.1]
  def self.up
    rename_column :items, :orders_id, :order_id
    rename_column :items, :users_id, :user_id
  end
end
