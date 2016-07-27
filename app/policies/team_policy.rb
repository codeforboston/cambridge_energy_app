class TeamPolicy < ApplicationPolicy
  def show?
    user.team_id == record.id
  end

  def create?
    true
  end

  def update?
    user.team_id == record.id
  end

  def destroy?
    user.team_id == record.id
  end

  def leave?
    user.team_id == record.id
  end

  def leaderboard?
    true
  end

  def accept_or_decline?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
