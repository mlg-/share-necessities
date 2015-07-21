class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.integer :user_id, null: false
      t.integer :organization_id, null: false
      t.string :url
      t.text :page_html
    end
  end
end
