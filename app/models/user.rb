class User < ActiveRecord::Base
  has_many :organizers
  has_many :organizations, through: :organizers
  has_many :dibs
  has_many :items, through: :dibs

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :profile_photo, ProfilePhotoUploader

  def self.organizer?(user)
    return true unless Organizer.where(user_id: user.id).empty?
  end
end
