class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.integer :tag_id
      t.integer :situation_id

      t.timestamps null: false
    end
  end
end
