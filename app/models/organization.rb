class Organization < ActiveRecord::Base
  has_many :organizers
  has_many :users, through: :organizers
  has_many :items

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :zip, presence: true
  validates :email, presence: true

  mount_uploader :display_photo, DisplayPhotoUploader

  def organizer?(user)
    return true if organizers.any? { |o| o[:user_id] == user.id }
  end
end