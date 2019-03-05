class UserPolicy < ApplicationPolicy
  def show?
    # verify if profile is from a user that is patient of current user
    patient = !user.patients.where(id: record.id).blank?
    # chek if profile is from current user or if is from a patient
    record == user || patient
  end
end
