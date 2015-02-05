class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all.order(created_at: :desc)
      else

        # Vai buscar o valor numerico da clerance do utilizador para usar no Query
        user_clearance = User.clearances[user.clearance]
        levels = Comment.levels
        # binding.pry
        scope.order(created_at: :desc).where("sensitivity <= :user_clearance AND (((owner_organization = :organization_id) 
              AND (level = :local_level)) 
              OR  ((:user_country = (SELECT country FROM organizations WHERE id = owner_organization LIMIT 1)) 
              AND (level = :national_level))  OR 
              (level = :international_level) )",
              {organization_id: user.organization.id, user_clearance: user_clearance, 
                user_country: user.organization.country, local_level: levels[:Local],
                national_level: levels[:National], international_level: levels[:International]})
      end
    end
  end

  def show?
     false
  end

  def new?
    user.admin? || user.p4? || user.p3? || user.p2?
  end

  def create?
    @evento = Event.find(@record.event.id)
    @situation=@evento.situation
    @situation.active? && (user.admin? || user.p4? || user.p3? || user.p2?)
  end

  def update?
     false
  end

  def destroy?
    false
  end

  #alias_method :new?, :create?
  alias_method :edit?, :update?
end
