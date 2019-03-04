class CreateUserDiseases < ActiveRecord::Migration[5.2]
  def change
    create_table :user_diseases do |t|
      t.references :user, foreign_key: true
      t.references :disease, foreign_key: true

      t.timestamps
    end
  end
end
