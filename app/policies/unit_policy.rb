class UnitPolicy < ApplicationPolicy
  def show?
    user.unit_id == record.id
  end

  def update?
    user.unit_id == record.id
  end

  def destroy?
    user.unit_id == record.id
  end

  def create?
    true
  end

  def leave?
    true
  end
end
