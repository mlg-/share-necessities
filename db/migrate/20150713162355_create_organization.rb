class CreateOrganization < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.text :description
      t.string :phone
      t.string :email, null: false
      t.string :url
      t.string :display_photo
      t.text :delivery_instructions

      t.timestamps null: false
    end
  end
end
