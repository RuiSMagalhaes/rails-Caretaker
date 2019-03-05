class UserPolicy < ApplicationPolicy
  def show?
    caretaker = !Relation.where(caretaker_user_id: user.id, patient_user_id: record.id).blank?
    record == user || caretaker
  end
end
