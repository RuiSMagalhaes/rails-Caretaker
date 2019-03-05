class AddDefaultValueToDismissAttribute < ActiveRecord::Migration[5.2]
  def change
    change_column :notifications, :dismissed, :boolean, default: false
  end
end
