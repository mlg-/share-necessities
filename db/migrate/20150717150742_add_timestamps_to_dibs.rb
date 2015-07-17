class AddTimestampsToDibs < ActiveRecord::Migration
  def change
    add_column :dibs, :created_at, :datetime, null: false
    add_column :dibs, :updated_at, :datetime, null: false
  end
end
