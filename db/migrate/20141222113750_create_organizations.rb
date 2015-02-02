class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :country
      t.boolean :active, default: true
      t.integer :creator_organization, index: true

      t.timestamps null: false
    end
  end
end
