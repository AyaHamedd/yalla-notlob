class Item < ApplicationRecord
  belongs_to :order
  belongs_to :user

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true

  after_create_commit -> { broadcast_append_to order }
  after_destroy_commit -> {broadcast_remove_to order }
end
