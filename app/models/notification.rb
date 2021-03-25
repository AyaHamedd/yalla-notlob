class Notification < ApplicationRecord
    belongs_to :recipient, class_name: "User"
    belongs_to :actor, class_name: "User"
    belongs_to :order, class_name: "Order"

    scope :unread, -> { where(read_at: nil) }
    scope :unrecieved , -> {where(recieved: false)}
end
