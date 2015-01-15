class OrganizationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if defined?(user.id)==nil # will now return true or false
            scope.active.where("name  <> :orgadmin", {orgadmin: "ADMIN"})        
      else
         if user.admin? 
            scope.where("name  <> :orgadmin", {orgadmin: "ADMIN"})
          else
            if user.p4?
                scope.where(
                             "(name  <> :orgadmin) AND 
                              ((active='t') OR  
                               ( (active = 'f') AND (creator_org = :creator_organization) AND (creator_country=:creator_country) )
                              )", {orgadmin: "ADMIN",
                              creator_organization: user.organization.name, creator_country: user.organization.country, true: "true", false: "false"})
            else
              if !user.p0? 
                 scope.active.where("name  <> :orgadmin", {orgadmin: "ADMIN"})
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
    user.admin? || (user.p4? && (record.creator_org==user.organization.name) && (record.creator_country==user.organization.country)) || (user.p4? && record== user.organization)
  end

  alias_method :update?, :edit?
  alias_method :new?, :create?
end
