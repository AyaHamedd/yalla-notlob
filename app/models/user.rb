class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  has_many :users, class_name: "Friend", foreign_key: "users_id"
  has_many :groups

  has_many :friend
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  has_many :orders

  has_and_belongs_to_many :orders
  has_many :notifications , foreign_key: :recipient_id
end
