class AddOrganizationToUser < ActiveRecord::Migration
  def change
    add_column :users, :organization_id, :integer, index: true
  end
end
