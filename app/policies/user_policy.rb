class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    # verify if profile is from a user that is patient of current user
    # chek if profile is from current user or if is from a patient
    record == user || record.caretakers.include?(user)
  end

  def edit?
    show?
  end

  def update?
    show?
  end

  def new?
    show?
  end

  def create?
    show?
  end

  def destroy?
    show?
  end
end
