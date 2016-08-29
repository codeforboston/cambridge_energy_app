class UserPolicy < ApplicationPolicy
  def update?
    true
  end

  def show?
    true
  end
end
