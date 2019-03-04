class AddColumnsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :description, :text
    add_column :events, :end_time, :datetime
    add_column :events, :recurring, :boolean
    add_column :events, :minutes, :integer
    add_column :events, :hours, :integer
    add_column :events, :days, :integer
    add_column :events, :weeks, :integer
    add_column :events, :months, :integer
    add_column :events, :start_id, :integer
    add_column :events, :notify_before, :boolean
    add_column :events, :notify_done, :boolean
    add_column :events, :notify_missed, :boolean
    add_reference :events, :user, foreign_key: true
    add_reference :events, :event_type, foreign_key: true
  end
end
