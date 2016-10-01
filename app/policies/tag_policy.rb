class TagPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all.order(body: :asc)
      else
        []
      end
    end
  end


  def index?
    return true if user.admin?
  end

  def show?
    return true if user.admin?
  end

  def create?
    return true if user.admin?
  end

  def update?
    return true if user.admin?
  end
  def destroy?
    return true if user.admin?
  end

  alias_method :new?, :create?
  alias_method :edit?, :update?
end
