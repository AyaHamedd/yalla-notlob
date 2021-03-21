class RenameColumnInOrders < ActiveRecord::Migration[6.1]
  def self.up
    rename_column :orders, :type, :order_type
  end
end
