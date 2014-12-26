class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user, index: true
      t.text :body
      t.integer :event_id
      t.integer :sensitivity
      t.integer :level

      t.timestamps null: false
    end
  end
end
