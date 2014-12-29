class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :clearance, :integer
    add_column :users, :organization_id, :integer, index: true
    add_column :users, :role, :integer

  end
end
