class CreateOrganizers < ActiveRecord::Migration
  def change
    create_table :organizers do |t|
      t.integer :user, null: false
      t.integer :organization, null: false
    end
  end
end
