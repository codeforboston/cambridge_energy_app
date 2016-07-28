class TipPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

  def share?
    true
  end

  def next?
    true
  end

  def like?
    true
  end

  def dislike?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
