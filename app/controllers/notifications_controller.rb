class NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @notifications = Notification.where(recipient: current_user).unread.unrecieved
    @allNotifications = Notification.where(recipient: current_user)
  end
  
  def mark_as_read
    @notifications = Notification.where(recipient: current_user).unread
    @notifications.update_all(read_at: Time.zone.now)
    render json: {success: true}
  end 

  def mark_as_recieved
    @notifications = Notification.where(recipient: current_user).unrecieved
    @notifications.update_all(recieved: true)
    render json: {success: true}
  end 

end
