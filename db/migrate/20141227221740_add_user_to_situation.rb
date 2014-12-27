class AddUserToSituation < ActiveRecord::Migration
  def change
    add_column :situations, :user_id, :integer, index: true
  end
end
