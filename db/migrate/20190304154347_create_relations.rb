class CreateRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :relations do |t|
      t.integer :caretaker_user_id
      t.integer :patient_user_id
      t.boolean :state

      t.timestamps
    end
  end
end
