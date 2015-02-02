class OrganizationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if defined?(user.id)==nil # At the sign-up page, no user is yet defined
            scope.active.order(country: :asc).where("name  <> :orgadmin", {orgadmin: "ADMIN"})        
      else
         if user.admin? 
            scope.order(country: :asc).where("name  <> :orgadmin", {orgadmin: "ADMIN"})
          else
            if user.p4?
                scope.order(country: :asc).where(
                             "(name  <> :orgadmin) AND 
                              ((active='t') OR  
                               ( (active = 'f') AND (creator_organization = :user_organization) )
                              )", {orgadmin: "ADMIN",
                              user_organization: user.organization.id, true: "true", false: "false"})
            else
              if !user.p0? 
                 scope.active.order(country: :asc).where("name  <> :orgadmin", {orgadmin: "ADMIN"})
              else
                 scope.active.where(id: user.organization.id)
              end
            end
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

  def edit?
    user.admin? || (user.p4? && (record.creator_organization==user.organization.id))
  end

  alias_method :update?, :edit?
  alias_method :new?, :create?
end
