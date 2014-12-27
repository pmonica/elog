require 'spec_helper'

describe SituationPolicy do

  let(:situation) { FactoryGirl.create(:situation) }
  let(:user) { situation.user }

  subject { SituationPolicy }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    it "denies access if situation is not from the user's organization" do
      expect(subject).not_to permit(FactoryGirl.create(:user), situation)
    end

    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :update? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
