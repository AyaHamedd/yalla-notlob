json.newNotifications(@notifications) do |notification|
    json.id notification.id
    json.actor notification.actor.full_name
    if notification.action=="joined"
        json.text "joined your #{notification.order.order_type}"
        json.link "Order."
    else
        json.text "invited you to his/her order"
        json.link "Join"
    end
    json.unread !notification.read_at?
    json.url order_path(notification.order)
end

json.allNotifications(@allNotifications) do |notification|
    json.id notification.id
    json.actor notification.actor.full_name
    if notification.action=="joined"
        json.text "joined your #{notification.order.order_type}"
        json.link "Order."
    else
        json.text "invited you to his/her order"
        json.link "Join"
    end
    json.unread !notification.read_at?
    json.url order_path(notification.order)
end