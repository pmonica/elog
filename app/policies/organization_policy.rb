class OrganizationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin? || user.p3?
        scope.where("name  <> :orgadmin", {orgadmin: "ADMIN"})
      else
        scope.where(id: user.organization.id)
      end
    end
  end

  def show?
    user.admin? || user.p3? || record == user.organization
  end

  def create?
    user.admin?
  end

  alias_method :update?, :create?
  alias_method :destroy?, :create?
  alias_method :new?, :create?
  alias_method :edit?, :create?
end
