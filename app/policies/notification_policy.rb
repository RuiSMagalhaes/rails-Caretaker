class NotificationPolicy < ApplicationPolicy
  def index?
    true
  end
  
  def create?
    true
  end

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
