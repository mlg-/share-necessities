class Item < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user
  has_one :dib

  validates :name, presence: true, length: { maximum: 200 }
  validates :quantity, presence: true, numericality: true
  validates :organization, presence: true

  include PgSearch
    pg_search_scope :search,
      :against => :name,
      :using => {
        :tsearch => {:prefix => true}
      }
end
