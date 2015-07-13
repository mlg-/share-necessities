class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :admin, :boolean, null: false, default: false
    add_column :users, :profile_photo, :string
    add_column :users, :bio, :text
  end
end
