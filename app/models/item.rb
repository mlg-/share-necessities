class Item < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user
  has_one :dib

  validates :name, presence: true
  validates :quantity, presence: true
  validates :organization, presence: true
end
