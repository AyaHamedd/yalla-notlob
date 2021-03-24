class Friend < ApplicationRecord
 

  validates_uniqueness_of :users_id, :scope => :friend_id

  belongs_to :users , class_name: "User", foreign_key: "friend_id"

end