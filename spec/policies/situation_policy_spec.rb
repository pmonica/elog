require 'spec_helper'

describe SituationPolicy do
  subject { SituationPolicy }

  let(:situation) { FactoryGirl.create(:situation) }
  let(:user) { situation.user }
  let(:policy_scope) { SituationPolicy::Scope.new(user, Situation).resolve }

  before(:each) do
    situation.update_attributes(organizations: [situation.organization])
    user.update_attributes(organization: situation.organization)
  end

  permissions "show?" do
    it "does not list situations with higher sensitivity than current user's clearance" do
      expect(policy_scope).to eq []
      expect(subject).not_to permit(user, situation)
    end

    it "when admin it lists situations with higher sensitivity than current user's clearance" do
      user.update_attributes(role: :admin)
      expect(policy_scope).to eq [situation]
      expect(subject).to permit(user, situation)
    end

    it "lists situations with equal sensitivity than current user's clearance" do
      situation.update_attributes(sensitivity: :publico)
      expect(policy_scope).to eq [situation]
      expect(subject).to permit(user, situation)
    end

    it "lists situations with lower sensitivity than current user's clearance" do
      situation.update_attributes(sensitivity: :privado)
      user.update_attributes(clearance: :secreto)
      expect(policy_scope).to eq [situation]
      expect(subject).to permit(user, situation)
    end

    it "when admin it list situations when organization doesn't participate in them" do
      situation.update_attributes(sensitivity: :publico, organizations: [])
      user.update_attributes(clearance: :secreto)
      user.update_attributes(role: :admin)
      expect(policy_scope).to eq [situation]
      expect(subject).to permit(user, situation)
    end

      it "does not list situations when organization doesn't participate in them" do
      situation.update_attributes(sensitivity: :publico, organizations: [])
      user.update_attributes(clearance: :secreto)
      expect(policy_scope).to eq []
      expect(subject).not_to permit(user, situation)
    end

    it "lists situations when level is national and organization is in the same country" do
      new_org = FactoryGirl.create(:organization, country: situation.organization.country)
      situation.update_attributes(level: :national, sensitivity: :publico, organization: new_org,
        organizations: [new_org, user.organization])
      expect(policy_scope).to eq [situation]
      expect(subject).to permit(user, situation)
    end

    it "does not list situations when level is national and organization is different country" do
      new_org = FactoryGirl.create(:organization, country: 'Other Country')
      situation.update_attributes(level: :national, sensitivity: :publico, organization: new_org,
        organizations: [new_org, user.organization])
      expect(policy_scope).to eq []
      expect(subject).not_to permit(user, situation)
    end

    it "lists situations when level is local and organization is owner" do
      situation.update_attributes(level: :local, sensitivity: :publico)
      expect(policy_scope).to eq [situation]
      expect(subject).to permit(user, situation)
    end

    it "does not list situations when level is local and organization is not the owner" do
      new_org = FactoryGirl.create(:organization, country: situation.organization.country)
      situation.update_attributes(level: :local, sensitivity: :publico, organization: new_org,
        organizations: [new_org, user.organization])
      expect(policy_scope).to eq []
      expect(subject).not_to permit(user, situation)
    end

    it "lists situations when level international" do
      situation.update_attributes(level: :international, sensitivity: :publico)
      expect(policy_scope).to eq [situation]
      expect(subject).to permit(user, situation)
    end

    it "does not list situations when level international but sensitivity is secret" do
      situation.update_attributes(level: :international, sensitivity: :secreto)
      expect(policy_scope).to eq []
      expect(subject).not_to permit(user, situation)
    end

    it "does not list situations when active is false" do
      situation.update_attributes(active: false, sensitivity: :publico)
      expect(policy_scope).to eq []
      expect(subject).not_to permit(user, situation)
    end

    it "when admin it lists situations when active is false" do
      situation.update_attributes(active: false, sensitivity: :publico)
      user.update_attributes(role: :admin)
      expect(policy_scope).to eq [situation]
      expect(subject).to permit(user, situation)
    end

    it "allows user with private to access public situation" do
      situation.update_attributes(sensitivity: :publico)
      user.update_attributes(clearance: :privado)

      expect(policy_scope).to eq [situation]
      expect(subject).to permit(user, situation)
    end
  end

  permissions :create? do
    it "creates a new situation when user is admin or p3" do
      user.update_attributes(role: :admin)
      expect(subject).to permit(user, Situation)
      user.update_attributes(role: :p3)
      expect(subject).to permit(user, Situation)
    end

    it "does not allow user to create a situation if p1 or p2" do
      user.update_attributes(role: :p2)
      expect(subject).not_to permit(user, Situation)
      user.update_attributes(role: :p1)
      expect(subject).not_to permit(user, Situation)
    end
  end

  permissions :update? do
    it "updates a new situation when user is admin" do
      user.update_attributes(role: :admin)
      expect(subject).to permit(user, situation)
    end

    it "updates a new situation when user is p3 and owner" do
      situation.update_attributes(sensitivity: :publico)
      user.update_attributes(role: :p3)
      expect(subject).to permit(user, situation)
    end

    it "does not allow user to update a situation when p3 but not owner" do
      user.update_attributes(role: :p3)
      situation.update_attributes(organization: FactoryGirl.create(:organization))
      expect(subject).not_to permit(user, situation)
    end

    it "does not allow user to update a situation when p2 or p1" do
      user.update_attributes(role: :p2)
      expect(subject).not_to permit(user, situation)
      user.update_attributes(role: :p1)
      expect(subject).not_to permit(user, situation)
    end
  end

  permissions :destroy? do
    it "never allows a user to delete a situation" do
      user.update_attributes(role: :admin)
      expect(subject).not_to permit(user, situation)
      user.update_attributes(role: :p3)
      expect(subject).not_to permit(user, situation)
      user.update_attributes(role: :p2)
      expect(subject).not_to permit(user, situation)
      user.update_attributes(role: :p1)
      expect(subject).not_to permit(user, situation)
    end
  end
end
