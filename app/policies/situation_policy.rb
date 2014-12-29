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
          .where("organization_id = :organization_id AND sensitivity <= :user_clearance
          AND (((owner_organization = :organization_id) AND (level = :local_level)) OR
            ((:user_country = (SELECT country FROM organizations WHERE id = owner_organization LIMIT 1)) AND (level = :national_level)) OR
            (level = :international_level))",
          {organization_id: user.organization.id, user_country: user.organization.country,
            user_clearance: user_clearance, local_level: levels[:local],
            national_level: levels[:national], international_level: levels[:internacional]})
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
