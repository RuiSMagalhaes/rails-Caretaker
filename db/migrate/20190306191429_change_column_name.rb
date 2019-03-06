class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :notifications, :type, :notification_type
  end
end
