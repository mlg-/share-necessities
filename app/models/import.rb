class Import < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  validates :user, presence: true
  validates :organization, presence: true

  def self.retrieve_wishlist_data(url)
    conn = Faraday.new(:url => url) do |faraday|
      faraday.use FaradayMiddleware::FollowRedirects
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    conn.get(url).body
  end

  def self.find_wishlist_pages(first_page_data, user_supplied_url)
    first_page = Nokogiri::HTML.parse(first_page_data)
    # find out how many page of items there are to query
    pagination_info = first_page.xpath(".//*[@id='wishlistPagination']/span/div/ul/li[@class='a-']/a").collect
    page_urls = pagination_info.map {|link| "http://amazon.com#{link[:href]}"}
    page_urls.unshift(user_supplied_url)
  end

  def self.parse_wishlist(response)
    wishlist_page_html = Nokogiri::HTML.parse(response)
    items_array = []
  item_names(wishlist_page_html)
    items_array
  end

  def self.item_names
    item_names = wishlist_page_html.xpath("//a[contains(@id,'itemName')]").collect(&:text)
    item_names.map! { |name| name.squish }
    item_names.each do |name|
      item_hash = {}
      item_hash["name"] = name
      items_array << item_hash
    end
  end

  def self.wishlist(user_supplied_url)
    first_page_data = retrieve_wishlist_data(user_supplied_url)
    pages = find_wishlist_pages(first_page_data, user_supplied_url)
    all_wishlist_items = []
    pages.each do |page|
      binding.pry
      response = retrieve_wishlist_data(page)
      page_of_items = parse_wishlist(response)
      all_wishlist_items += page_of_items
    end
    all_wishlist_items
  end
end