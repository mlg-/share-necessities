class Import < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  validates :user, presence: true
  validates :organization, presence: true

  def self.retrieve_wishlist_data(url)
    conn = Faraday.new(:url => url) do |faraday|
      faraday.use FaradayMiddleware::FollowRedirects
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
    conn.get(url).body
  end

  def self.find_wishlist_pages(first_page_data, user_supplied_url)
    first_page = Nokogiri::HTML.parse(first_page_data)
    # find out how many page of items there are to query
    pagination_info = first_page.xpath(".//*[@id='wishlistPagination']/span/div/ul/li[@class='a-']/a").collect
    page_urls = pagination_info.map { |link| "http://amazon.com#{link[:href]}" }
    page_urls.unshift(user_supplied_url)
  end

  def self.get_item_names(items, wishlist_page_html)
    item_names = wishlist_page_html.xpath("//a[contains(@id,'itemName')]").collect(&:text)
    item_names.map! { |name| name.squish }
    item_names.each do |name|
      item_hash = {}
      item_hash["name"] = name
      items << item_hash
    end
    items
  end

  def self.get_item_urls(items, wishlist_page_html)
    item_urls_data = wishlist_page_html.xpath("//*[contains(@id, 'itemInfo')]/div/div[1]/div[1]/h5/a[contains(@id, 'itemName')]").collect
    item_urls = item_urls_data.map { |data| "http://amazon.com#{data[:href]}" }
    i = 0
    items.each do |item|
      item["url"] = item_urls[i]
      i += 1
    end
    items
  end

  def self.get_item_quantities(items, wishlist_page_html)
    item_quantities = wishlist_page_html.xpath(".//*[contains(@id, 'itemRequested_')]").collect(&:text)
    item_quantities.map! { |data| data.squish }
    i = 0
    items.each do |item|
      item["quantity"] = item_quantities[i]
      i += 1
    end
  end

  def self.parse_wishlist(response)
    wishlist_page_html = Nokogiri::HTML.parse(response)
    items = []
    item_names = get_item_names(items, wishlist_page_html)
    item_names_urls = get_item_urls(item_names, wishlist_page_html)
    final_items = get_item_quantities(item_names_urls, wishlist_page_html)
    final_items
  end

  def self.wishlist(user_supplied_url)
    first_page_data = retrieve_wishlist_data(user_supplied_url)
    pages = find_wishlist_pages(first_page_data, user_supplied_url)
    all_wishlist_items = []
    pages.each do |page|
      response = retrieve_wishlist_data(page)
      page_of_items = parse_wishlist(response)
      all_wishlist_items += page_of_items
    end
    all_wishlist_items
  end
end