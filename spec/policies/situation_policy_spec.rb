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

  permissions ".scope" do
    it "does not list situations with higher sensitivity than current user's clearance" do
      expect(policy_scope).to eq []
    end

    it "lists situations with equal sensitivity than current user's clearance" do
      situation.update_attributes(sensitivity: :publico)
      expect(policy_scope).to eq [situation]
    end

    it "lists situations with lower sensitivity than current user's clearance" do
      situation.update_attributes(sensitivity: :privado)
      user.update_attributes(clearance: :secreto)
      expect(policy_scope).to eq [situation]
    end

    it "does not list situations when organization doesn't participate in them" do
      situation.update_attributes(sensitivity: :publico, organizations: [])
      user.update_attributes(clearance: :secreto)
      expect(policy_scope).to eq []
    end

    it "lists situations when level is national and organization is in the same country" do
      new_org = FactoryGirl.create(:organization, country: situation.organization.country)
      situation.update_attributes(level: :national, sensitivity: :publico, organization: new_org,
        organizations: [new_org, user.organization])
      expect(policy_scope).to eq [situation]
    end

    it "does not list situations when level is national and organization is different country" do
      new_org = FactoryGirl.create(:organization, country: 'Other Country')
      situation.update_attributes(level: :national, sensitivity: :publico, organization: new_org,
        organizations: [new_org, user.organization])
      expect(policy_scope).to eq []
    end

    it "lists situations when level is local and organization is owner" do
      situation.update_attributes(level: :local, sensitivity: :publico)
      expect(policy_scope).to eq [situation]
    end

    it "does not list situations when level is local and organization is not the owner" do
      new_org = FactoryGirl.create(:organization, country: situation.organization.country)
      situation.update_attributes(level: :local, sensitivity: :publico, organization: new_org,
        organizations: [new_org, user.organization])
      expect(policy_scope).to eq []
    end

    it "lists situations when level international" do
      situation.update_attributes(level: :internacional, sensitivity: :publico)
      expect(policy_scope).to eq [situation]
    end

    it "does not list situations when level international but sensitivity is secret" do
      situation.update_attributes(level: :internacional, sensitivity: :secreto)
      expect(policy_scope).to eq []
    end

  end

  permissions :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    it "denies access if situation is not from the user's organization" do
      expect(subject).not_to permit(FactoryGirl.create(:user), situation)
    end

    it "allows access if situation is  from the user's organization" do
      expect(subject).to permit(user, situation)
    end
  end

  permissions :update? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
