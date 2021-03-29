class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  has_many :users, class_name: "Friend", foreign_key: "users_id"
  has_many :groups

  has_many :friend
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook,:google_oauth2]
  has_many :items
  has_many :orders

  has_and_belongs_to_many :orders
  has_many :notifications , foreign_key: :recipient_id
  
  has_one_attached :avatar
  after_commit :add_default_avatar, on: %i[create update]

  def self.from_omniauth(auth)
    abort auth.inspect
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.full_name = auth.info.name
    # skiping eamil confirmation when use the providers 
    # user.skip_confirmation!
    user.save!
    end
  end




  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "150x150!").processed 
    else
      "/default.jpg"
    end
  end
  
  private
  def add_default_avatar
	  unless avatar.attached?
		  avatar.attach(
			  io: File.open(
          Rails.root.join(
				  'app','assets','images','default.jpg'
				)
			), 
      filename: 'default.jpg',
			content_type: 'image/jpg'
		)
		end
	end
end


