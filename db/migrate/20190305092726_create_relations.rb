class CreateRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :relations do |t|
      t.integer 'caretaker_id', null: false
      t.integer 'patient_id', null: false
      t.boolean :state

      t.timestamps null: false
    end

    add_index :relations, :caretaker_id
    add_index :relations, :patient_id
    add_index :relations, [:caretaker_id, :patient_id], unique: true
  end
end
