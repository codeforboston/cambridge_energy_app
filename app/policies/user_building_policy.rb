class UserBuildingPolicy < ApplicationPolicy
  def update?
    user.unit.user_building_id == record.id
  end

  def destroy?
    user.unit.user_building_id == record.id
  end

  def show?
    true
  end

  def create?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
