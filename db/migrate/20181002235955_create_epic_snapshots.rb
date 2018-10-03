class CreateEpicSnapshots < ActiveRecord::Migration[5.0]
  def change
    create_table :epic_snapshots do |t|
      t.references :epics
      t.integer :completed_storypoints
      t.integer :total_storypoints

      t.timestamps
    end
  end
end
