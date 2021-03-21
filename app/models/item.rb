class Item < ApplicationRecord
  belongs_to :order
  belongs_to :user

  after_create_commit -> { broadcast_append_to order}
end
