class Item < ApplicationRecord
  belongs_to :order
  belongs_to :user

  validates :name, presence: true # a title must be present
  validates :price, presence: true
  validates :quantity, presence: true

  after_create_commit -> { broadcast_append_to order }
end
