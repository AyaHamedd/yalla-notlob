json.array! @notifications do |notification|
    json.id notification.id
    json.actor notification.actor.full_name
    json.action notification.action
    json.order notification.order
    json.unread !notification.read_at?
    json.url order_path(notification.order)
end