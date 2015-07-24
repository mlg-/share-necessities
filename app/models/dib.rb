class Dib < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  validates :user, presence: true
  validates :item, presence: true
  validates :quantity, presence: true

  def self.incoming_dibs_list(items)
    all_dibs = []
    items.each do |item|
      unless item.dibs.nil?
        item.dibs.each do |dib|
          unless dib.status == "Received"
            dib_info = {}
            dib_info[:name] = item.name
            dib_info[:quantity] = dib.quantity
            dib_info[:volunteer] = User.find(dib.user_id).first_name
            dib_info[:date] = dib.created_at.strftime("%B %d, %Y")
            dib_info[:item_id] = item.id
            dib_info[:dib_id] = dib.id
            dib_info[:organization_id] = item.organization.id
            all_dibs << dib_info
          end
        end
      end
    end
    all_dibs
  end
end
