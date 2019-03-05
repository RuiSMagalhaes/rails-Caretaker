class Relation < ApplicationRecord
  belongs_to :caretaker, foreign_key: 'caretaker_id', class_name: 'User'
  belongs_to :patient, foreign_key: 'patient_id', class_name: 'User'


end

# permite fazer rel= Releation.create.....
# rel.patient e rel.caretaker => User instance
