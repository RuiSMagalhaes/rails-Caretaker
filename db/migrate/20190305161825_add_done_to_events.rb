class AddDoneToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :done, :boolean, default: false
  end
end
