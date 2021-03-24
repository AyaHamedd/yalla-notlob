class Order < ApplicationRecord
    belongs_to :user

    has_many :items
    has_and_belongs_to_many :invited_users, class_name: "User", join_table: :invited_users
    has_and_belongs_to_many :users

    # broadcasts_to ->(order) { "new_item", partial: "items/form" }
    after_update_commit -> {broadcast_replace_to "orders_index" }
end
