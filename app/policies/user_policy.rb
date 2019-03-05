class UserPolicy < ApplicationPolicy
  def show?
    relations = Relation.where(patient_user_id: record.id)
    caretaker = false
    relations.each do |relation|
      caretaker = true if relation.caretaker_user_id == record.id
    end
    record == user || caretaker
  end
end
