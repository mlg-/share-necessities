class CreateOrganizers < ActiveRecord::Migration
  def change
    create_table :organizers do |t|
      t.integer :user_id, null: false
      t.integer :organization_id, null: false
    end
  end
end
