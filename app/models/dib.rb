class Dib < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  validates :user, presence: true
  validates :item, presence: true
  validates :quantity, presence: true

  def self.dibs_list(items)
    all_dibs = []
    items.each do |item|
      unless item.dib.nil?
        binding.pry
        dib = {}
        dib[item] = Dib.where(item: item).first
        all_dibs << dib
      end
    end
    all_dibs
  end
end
