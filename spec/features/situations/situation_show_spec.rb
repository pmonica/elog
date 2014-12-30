require 'rails_helper'

feature 'User views situation' do
  let!(:situation) { FactoryGirl.create(:situation) }
  let!(:user) { situation.user }

  before(:each) do
    user.update_attributes(organization: situation.organization, role: :p3, clearance: :secreto)
    situation.update_attributes(organizations: [situation.organization])
    signin(user.email, user.password)
  end

  scenario 'with valid credentials' do
    visit situation_path(situation)
    expect(page).to have_content situation.name
    expect(page).to have_content situation.organization.name
  end
end