class Item < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user

  validates :name, presence: true
  validates :quantity, presence: true
  validates :organization, presence: true
  validates :user, presence: true
  validates :status, presence: true
end