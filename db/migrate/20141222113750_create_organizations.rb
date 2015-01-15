class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :country
      t.boolean :active, default: true
      t.string :creator_org
      t.string :creator_country

      t.timestamps null: false
    end
  end
end
