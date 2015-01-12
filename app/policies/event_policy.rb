class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else

        # Vai buscar o valor numerico da clerance do utilizador para usar no Query
        user_clearance = User.clearances[user.clearance]
        levels = Event.levels
        scope.order(created_at: :desc).where("sensitivity <= :user_clearance AND (((owner_organization = :organization_id) 
              AND (level = :local_level)) 
              OR  ((:user_country = (SELECT country FROM organizations WHERE id = owner_organization LIMIT 1)) 
              AND (level = :national_level))  OR 
              (level = :international_level) )",
              {organization_id: user.organization.id, user_clearance: user_clearance, 
                user_country: user.organization.country, local_level: levels[:local],
                national_level: levels[:national], international_level: levels[:international]})
      end
    end
  end

  def show?
     false
  end

  def create?
    user.admin? || user.p3? || user.p2?
  end

  def update?
     false
  end

  def destroy?
    false
  end

  alias_method :new?, :create?
  alias_method :edit?, :update?
end
