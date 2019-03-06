class AddRecurringTimesToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :recurring_times, :integer, default: 0
  end
end
