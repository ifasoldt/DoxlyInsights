class AddTotalTicketsAndCompletedTicketsToEpic < ActiveRecord::Migration[5.0]
  def change
    add_column :epics, :total_tickets, :integer
    add_column :epics, :completed_tickets, :integer
  end
end
