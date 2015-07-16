class CreateDibs < ActiveRecord::Migration
  def change
    create_table :dibs do |t|
      t.integer :user_id, null: false
      t.integer :quantity, null: false
      t.integer :item_id, null: false
      t.string :status, null: false, default: "Promised"
    end

    remove_column :items, :user_id, :integer, null: false
    remove_column :items, :status, :string, null: false, default: "Requested"
  end
end
