class Order < ApplicationRecord
    belongs_to :user

    has_many :items
    has_and_belongs_to_many :invited_users, class_name: "User", join_table: :invited_users
    has_and_belongs_to_many :users
end
