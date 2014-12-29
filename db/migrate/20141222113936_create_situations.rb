class CreateSituations < ActiveRecord::Migration
  def change
    create_table :situations do |t|
      t.string :name
      t.text :description
      t.integer :sensitivity
      t.integer :level
      t.boolean :active, default: true
      t.belongs_to :user, index: true
      t.integer :owner_organization, index: true

      t.timestamps null: false
    end
  end
end
