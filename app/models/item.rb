class Item < ApplicationRecord
  belongs_to :orders
  belongs_to :users
end
