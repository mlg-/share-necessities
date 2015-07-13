class Organization < ActiveRecord::Base
  has_many :organizers
  has_many :users, through: :organizers

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :zip, presence: true
  validates :email, presence: true

  mount_uploader :display_photo, DisplayPhotoUploader
end