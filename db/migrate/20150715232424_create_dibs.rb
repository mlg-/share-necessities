class CreateDibs < ActiveRecord::Migration
  def change
    create_table :dibs do |t|
      t.integer :user_id, null: false
      t.integer :quantity, null: false
      t.integer :item_id, null: false
    end

    remove_column :items, :user_id, :integer, null: false
  end
end
