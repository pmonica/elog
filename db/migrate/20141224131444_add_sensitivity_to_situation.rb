class AddSensitivityToSituation < ActiveRecord::Migration
  def change
    add_column :situations, :sensitivity, :integer
    add_column :situations, :level, :integer
  end
end
