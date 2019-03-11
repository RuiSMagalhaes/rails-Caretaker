class AddSenderIdToRelations < ActiveRecord::Migration[5.2]
  def change
    add_column :relations, :sender_id, :integer
  end
end
