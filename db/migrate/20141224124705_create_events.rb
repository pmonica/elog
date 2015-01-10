class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.text :title
      t.integer :situation_id
      t.integer :sensitivity
      t.integer :level
      t.boolean :decision, default: false
      t.integer :owner_organization, index: true

      t.timestamps null: false
    end
  end
end
