class SituationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all.order(updated_at: :desc)
      else
        # Vai buscar o valor numerico da clerance do utilizador para usar no Query
        user_clearance = User.clearances[user.clearance]
        levels = Situation.levels

        # If user is a P4, show inactive situations
        if user.role=='p4'
            scope.joins(:organizations).order(updated_at: :desc)
              .where("participations.organization_id = :organization_id AND sensitivity <= :user_clearance
              AND (((owner_organization = :organization_id) AND (level = :local_level)) OR
                ((:user_country = (SELECT country FROM organizations WHERE id = owner_organization LIMIT 1)) AND (level = :national_level)) OR
                (level = :international_level))",
              {organization_id: user.organization.id, user_country: user.organization.country,
                user_clearance: user_clearance, local_level: levels[:Local],
                national_level: levels[:National], international_level: levels[:International]})
        else
          if user.role!='p0'
            # Users P1 to P3 will only see active Situations
            scope.active.joins(:organizations).order(updated_at: :desc)
              .where("participations.organization_id = :organization_id AND sensitivity <= :user_clearance
              AND (((owner_organization = :organization_id) AND (level = :local_level)) OR
                ((:user_country = (SELECT country FROM organizations WHERE id = owner_organization LIMIT 1)) AND (level = :national_level)) OR
                (level = :international_level))",
              {organization_id: user.organization.id, user_country: user.organization.country,
                user_clearance: user_clearance, local_level: levels[:Local],
                national_level: levels[:National], international_level: levels[:International]})
          else
            # P0'S do not see anything
            []
          end
        end
      end
    end
  end

  def show?
    return true if user.admin?

    user_clearance = User.clearances[user.clearance]
    situation_sensitivity = Situation.sensitivities[record.sensitivity]
    if user.p4?
       record.organizations.include?(user.organization) && situation_sensitivity <= user_clearance &&
       ((record.owner_organization == user.organization && record.Local?) ||
       (record.owner_organization.country == user.organization.country && record.National?) ||
       (record.International?))

    else
       record.active? && record.organizations.include?(user.organization) && situation_sensitivity <= user_clearance &&
       ((record.owner_organization == user.organization && record.Local?) ||
       (record.owner_organization.country == user.organization.country && record.National?) ||
       (record.International?))
    end
  end

  def create?
    user.admin? || user.p3? || user.p4?
  end

  def update?
    return true if user.admin?
    show? && (user.p3? || user.p4?) && record.owner_organization == user.organization
  end

  def destroy?
    false
  end

  alias_method :new?, :create?
  alias_method :edit?, :update?
end
