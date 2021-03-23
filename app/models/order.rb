class Order < ApplicationRecord
    belongs_to :user

    has_many :items
    has_and_belongs_to_many :users
end
