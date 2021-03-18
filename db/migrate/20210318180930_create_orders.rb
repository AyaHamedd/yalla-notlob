class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :type
      t.string :status
      t.string :restaurant_name
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
    create_join_table :users, :orders
  end
end
