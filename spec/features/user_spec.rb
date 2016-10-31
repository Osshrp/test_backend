require "rails_helper"

feature "It shows profile page" do
  let!(:user) { FactoryGirl.create(:user) }
  scenario "and has Load button" do
    visit user_path user
    expect(page).to have_content "Your avatar"
  end
end