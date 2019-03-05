class NotificationPolicy < ApplicationPolicy
  def show?
    user == record.user
  end



  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
