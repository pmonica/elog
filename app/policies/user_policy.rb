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
           # Construct the list of child organizations of current_user's organization, to use in the scope SQL
           list="("
           temp=Organization.where(creator_organization: user.organization.id).each {|o| list=list+o.id.to_s+","}
           if list.length >= 3
             list=list[0..-2]+")"
           else
              list=list+")"
           end
           scope.order(organization_id: :desc).where("(organization_id = :user_organization) OR (organization_id IN "+list+")", {user_organization: user.organization.id})
        else
           scope.where("id = :user_id", {user_id: user.id})
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
