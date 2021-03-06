class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    # verify if profile is from a user that is patient of current user
    # chek if profile is from current user or if is from a patient
    record == user || record.caretakers.where('relations.state = true').include?(user)
  end

  def edit?
    (record == user && !record.simple_view) || record.caretakers.where('relations.state = true').include?(user)
  end

  def update?
    edit?
  end

  def new?
    edit?
  end

  def create?
    edit?
  end

  def destroy?
    edit?
  end
end
