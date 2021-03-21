class Friend < ApplicationRecord
  belongs_to :users, class-name: "user", foreign_key: "friend_id"
end
