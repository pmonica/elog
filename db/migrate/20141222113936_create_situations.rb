class CreateSituations < ActiveRecord::Migration
  def change
    create_table :situations do |t|
      t.string :name
      t.text :description
      t.timestamps null: false
    end
  end
end