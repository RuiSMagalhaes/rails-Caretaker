class NotificationPolicy < ApplicationPolicy

  def show?
    user == record.user
  end

  def update?
    user == record.event.user
  end

  def destroy?
    show?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
