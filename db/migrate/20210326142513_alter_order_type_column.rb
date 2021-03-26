class AlterOrderTypeColumn < ActiveRecord::Migration[6.1]
  def self.up
    change_column :orders, :order_type, :integer
  end
end
