class AddThumbnailsToItems < ActiveRecord::Migration
  def change
    add_column :items, :thumbnails, :string
  end
end
