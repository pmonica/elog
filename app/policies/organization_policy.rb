class OrganizationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if defined?(user)=="method" # will now return true or false
            scope.where("name  <> :orgadmin", {orgadmin: "ADMIN"})        
      else
         if user.admin? || user.p3? || user.p4?
            scope.where("name  <> :orgadmin", {orgadmin: "ADMIN"})
          else
            scope.where(id: user.organization.id)
          end 
      end
    end
  end

  def show?
    user.admin? || user.p3? || user.p4? || record == user.organization
  end

  def create?
    user.admin? || user.p4?
  end

  alias_method :update?, :create?
  alias_method :destroy?, :create?
  alias_method :new?, :create?
  alias_method :edit?, :create?
end
