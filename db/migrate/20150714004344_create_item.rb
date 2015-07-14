class CreateItem < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :title
    end

    create_table :items do |t|
      t.string :name, null: false
      t.integer :quantity, null: false
      t.string :url
      t.text :description
      t.integer :user_id
      t.integer :organization_id, null: false
      t.integer :status_id, null: false
    end
  end
end
