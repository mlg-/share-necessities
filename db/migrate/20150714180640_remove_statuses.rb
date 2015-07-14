class RemoveStatuses < ActiveRecord::Migration
  def up
    drop_table :statuses
  end

  def down
    create_table :statuses do |t|
      t.string :title, null: false
    end
  end
end
