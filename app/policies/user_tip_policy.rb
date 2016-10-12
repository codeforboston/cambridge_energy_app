class UserTipPolicy < ApplicationPolicy
  def show?
    user.id == record.user_id
  end

  def create?
    user.id == record.user_id
  end

  def update?
    user.id == record.user_id
  end

  def destroy?
    user.id == record.user_id
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
