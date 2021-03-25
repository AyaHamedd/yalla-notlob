class AddRecievedToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :recieved, :boolean, default: false
  end
end
