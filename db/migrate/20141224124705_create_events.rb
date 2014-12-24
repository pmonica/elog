class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :title
      t.integer :situation_id
      t.integer :sensitivity
      t.integer :level

      t.timestamps null: false
    end
  end
end
