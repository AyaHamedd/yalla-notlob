class Group < ApplicationRecord
    validates :name, presence: true

    has_belongs_to_many :groupusers, :through => :groupusers, dependent: :delete_all
end
