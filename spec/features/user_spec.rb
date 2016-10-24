require "rails_helper"

feature "User connects Flickr photos to card" do
  let!(:user) { FactoryGirl.create(:user) }
  scenario "it has Load button" do
    visit "#{api_v1_users_path}/#{user.id}"
    expect(page).to have_content "Load"
  end
end