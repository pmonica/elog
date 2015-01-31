class UserPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all.order(organization_id: :desc)
      else
        if user.p4?
           scope.order(created_at: :desc).where("organization_id = :user_organization", {user_organization: user.organization.id})
        else
           []
        end
      end # if
    end # def
  end # class




  def index?
    @current_user.admin? || @current_user.p4?
  end

  def show?
    @current_user.admin? or @current_user.p4? or @current_user == @user
  end

  def update?
    @current_user.admin? || @current_user.p4?
  end

  def destroy?
    return false if @current_user == @user
    @current_user.admin? || @current_user.p4?
  end

end
