class ChangeStatusColumnOnItems < ActiveRecord::Migration
  def change
    remove_column :items, :status_id, :integer, null: false
    add_column :items, :status, :string, null: false, default: "Requested"
  end
end
