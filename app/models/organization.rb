class Organization < ActiveRecord::Base
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :zip, presence: true
  validates :email, presence: true

  mount_uploader :display_photo, DisplayPhotoUploader
end