class AddIsActiveToEpics < ActiveRecord::Migration[5.0]
  def change
    add_column :epics, :is_active, :boolean, default: false
  end
end
