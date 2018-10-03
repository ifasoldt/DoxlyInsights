class CreateEpics < ActiveRecord::Migration[5.0]
  def change
    create_table :epics do |t|
      t.string :jira_id
      t.string :name
      t.integer :highest_storypoint_count
      t.datetime :origin_date
      t.integer :unestimated_tickets

      t.timestamps
    end
  end
end
