class NotificationPolicy < ApplicationPolicy
  def show?
    return false if record.dismissed == true

    user == record.user
  end

  def dismissed?
    show?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
