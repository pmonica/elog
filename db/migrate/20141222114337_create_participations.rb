class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.belongs_to :organization, index: true
      t.belongs_to :situation, index: true

      t.timestamps null: false
    end
  end
end
