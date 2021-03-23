class AddJoinTableInvitedUsersToOrder < ActiveRecord::Migration[6.1]
  def change
    create_join_table :users, :orders, table_name: :invited_users
  end
end
