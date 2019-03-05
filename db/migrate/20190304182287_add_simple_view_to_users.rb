class AddSimpleViewToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :simple_view, :boolean
  end
end
