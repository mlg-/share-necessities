class AddThumbnailsToItems < ActiveRecord::Migration
  def change
    add_column :items, :thumbnail_url, :string
  end
end
