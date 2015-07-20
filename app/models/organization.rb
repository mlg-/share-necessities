class Organization < ActiveRecord::Base
  has_many :organizers
  has_many :users, through: :organizers
  has_many :items

  validates :name, presence: true, length: { maximum: 250 }
  validates :address, presence: true, length: { maximum: 250 }
  validates :city, presence: true, length: { maximum: 100 }
  validates :zip, presence: true
  validates_format_of :email, with: /@/
  validates :delivery_instructions, length: { maximum: 1000 }
  validates :description, length: { maximum: 1000 }

  mount_uploader :display_photo, DisplayPhotoUploader

  paginates_per 20

  include PgSearch
    pg_search_scope :search,
      :against => :name,
      :using => {
        :tsearch => { :prefix => true }
      }

  def organizer?(user)
    return true if organizers.any? { |o| o[:user_id] == user.id }
  end
end