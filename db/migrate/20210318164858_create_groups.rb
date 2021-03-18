class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name

      t.timestamps
    end
    create_join_table :users, :groups
  end
end
