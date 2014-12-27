class SituationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.joins(:participations).where("organization_id = :organization_id" ,  {organization_id: user.organization.id})
      end
    end
  end

  def show?
    record.organizations.include?(user.organization)
  end

  def update?
    user.admin?
  end
end
