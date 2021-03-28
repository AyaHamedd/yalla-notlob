class Order < ApplicationRecord
    enum order_type: { breakfast: 0, lunch: 1, dinner: 2 }
    belongs_to :user

    has_many :items
    has_and_belongs_to_many :invited_users, class_name: "User", join_table: :invited_users
    has_and_belongs_to_many :users

    has_one_attached :restaurant_menu

    # broadcasts_to ->(order) { "new_item", partial: "items/form" }
    after_update_commit -> {broadcast_replace_to "orders_index" }
end
