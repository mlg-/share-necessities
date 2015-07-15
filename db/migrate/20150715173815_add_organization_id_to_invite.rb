class AddOrganizationIdToInvite < ActiveRecord::Migration
  def change
    add_column :users, :invited_by_organization_id, :integer
  end
end
