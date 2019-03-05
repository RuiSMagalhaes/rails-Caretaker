class EventPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    # if event belongs to corrent user or if event belongs to a current user patient
    record.user == user || record.user.caretakers.include?(user)
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    true
  end

  def edit?
    update?
  end

  def destroy?
    true
  end
end
