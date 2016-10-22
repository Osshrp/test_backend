require "rails_helper"

describe "Select users" do
  before do
    FactoryGirl.create_list(:user_with_posts, 2)
    interval = {start_date: 3.days.ago, end_date: Date.today }
    @users = SelectUsers.select(interval)
  end
  it "users should by an array" do
    expect(@users).to be_kind_of(Array)
  end

  it "users should cantain array of hashes" do
    expect(@users).to include(be_kind_of(Hash))
  end

  it "users should cantain nickname Nick" do
    expect(@users).to include(include(:nickname => "Nick"))
  end
end