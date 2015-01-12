class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user, index: true
      t.text :body
      t.integer :event_id, index: true
      t.integer :sensitivity
      t.integer :level
      t.integer :owner_organization, index: true

      t.timestamps null: false
    end
  end
end
