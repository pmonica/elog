class SituationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        # Vai buscar o valor numerico da clerance do utilizador para usar no Query
        user_clearance = User.clearances[user.clearance]
        levels = Situation.levels
        scope.active.joins(:organizations)
          .where("participations.organization_id = :organization_id AND sensitivity <= :user_clearance
          AND (((owner_organization = :organization_id) AND (level = :local_level)) OR
            ((:user_country = (SELECT country FROM organizations WHERE id = owner_organization LIMIT 1)) AND (level = :national_level)) OR
            (level = :international_level))",
          {organization_id: user.organization.id, user_country: user.organization.country,
            user_clearance: user_clearance, local_level: levels[:Local],
            national_level: levels[:National], international_level: levels[:International]})
      end
    end
  end

  def show?
    return true if user.admin?

    user_clearance = User.clearances[user.clearance]
    situation_sensitivity = Situation.sensitivities[record.sensitivity]

    record.active? && record.organizations.include?(user.organization) && situation_sensitivity <= user_clearance &&
      ((record.owner_organization == user.organization && record.Local?) ||
       (record.owner_organization.country == user.organization.country && record.National?) ||
       (record.International?))
  end

  def create?
    user.admin? || user.p3?
  end

  def update?
    return true if user.admin?

    show? && user.p3? && record.owner_organization == user.organization
  end

  def destroy?
    false
  end

  alias_method :new?, :create?
  alias_method :edit?, :update?
end
