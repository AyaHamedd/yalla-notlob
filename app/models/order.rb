class Order < ApplicationRecord
    has_many :items
    has_and_belongs_to_many :users
end
