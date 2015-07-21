class Import < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  validates :user, presence: true
  validates :organization, presence: true

  def self.wishlist_import(url)
    conn = Faraday.new(:url => url) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  response = conn.get(url)
  return response
  end
end