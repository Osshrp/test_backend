require "rails_helper"

feature "It shows profile page" do
  let!(:user) { FactoryGirl.create(:user) }
  scenario "and has Load button" do
    visit "#{api_v1_users_path}/#{user.id}"
    expect(page).to have_content "Load"
  end
end