class Dib < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  validates :user, presence: true
  validates :item, presence: true
  validates :quantity, presence: true

  def self.incoming_dibs_list(items)
    all_dibs = []
    items.each do |item|
      unless item.dib.nil? || item.dib.status == "Received"
        dib = {}
        dib[:name] = item.name
        dib[:quantity] = item.dib.quantity
        dib[:volunteer] = User.find(item.dib.user_id).first_name
        dib[:date] = item.dib.created_at.strftime("%B %d, %Y")
        dib[:item_id] = item.id
        dib[:dib_id] = item.dib.id
        dib[:organization_id] = item.organization.id
        all_dibs << dib
      end
    end
    all_dibs
  end
end
