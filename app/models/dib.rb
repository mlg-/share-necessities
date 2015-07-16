class Dib < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  validates :user, presence: true
  validates :item, presence: true
  validates :quantity, presence: true
end
