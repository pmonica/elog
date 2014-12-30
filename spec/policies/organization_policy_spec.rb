require 'spec_helper'

describe OrganizationPolicy do

  let(:user) { FactoryGirl.create(:user) }
  let(:policy_scope) { OrganizationPolicy::Scope.new(user, Organization).resolve }


  subject { OrganizationPolicy }

  permissions :show? do
    it "does not list organizations that are not the user's" do
      new_organization = FactoryGirl.create(:organization)
      expect(policy_scope).to eq [user.organization]
      expect(subject).not_to permit(user, new_organization)
    end

    it "lists the organization that the user belongs to" do
      expect(policy_scope).to eq [user.organization]
      expect(subject).to permit(user, user.organization)
    end

    it "lists all organizations when the user is p3" do
      new_organization = FactoryGirl.create(:organization)
      user.update_attributes(role: :p3)
      expect(policy_scope).to eq [new_organization, user.organization]
      expect(subject).to permit(user, new_organization)
    end

    it "lists all organizations when the user is admin" do
      new_organization = FactoryGirl.create(:organization)
      user.update_attributes(role: :admin)
      expect(policy_scope).to eq [new_organization, user.organization]
      expect(subject).to permit(user, new_organization)
    end
  end

  permissions :create? do
    it "creates a new organization when user is admin" do
      user.update_attributes(role: :admin)
      expect(subject).to permit(user, Organization)
    end

    it "does not allow user to create an organization when p1, p2 or p3" do
      user.update_attributes(role: :p3)
      expect(subject).not_to permit(user, Organization)
      user.update_attributes(role: :p2)
      expect(subject).not_to permit(user, Organization)
      user.update_attributes(role: :p1)
      expect(subject).not_to permit(user, Organization)
    end
  end
end
