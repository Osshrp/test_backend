require 'rails_helper'
require 'database_cleaner'

describe User, type: :model do
  it { should have_many :posts }
  it { should have_many :comments }

  it { should validate_presence_of :nickname }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe "Select users" do
  before do
    FactoryGirl.create_list(:user_with_posts, 2)
    interval = {start_date: 3.days.ago, end_date: Date.today }
    @users = User.select_users(interval)
  end
  it "users should by an array" do
    expect(@users).to be_kind_of(Array)
  end

  it "users should contain array of hashes" do
    expect(@users).to include(be_kind_of(Hash))
  end

  it "users should contain nickname Nick" do
    expect(@users).to include(include(:nickname => "Nick"))
  end

  it "should has corrent order" do
    DatabaseCleaner.clean
    expected_array = select_users(["Bill", "Jhon", "Linda"])
    interval = {start_date: 3.days.ago, end_date: Date.today }
    users = User.select_users(interval)

    expect(users).to match_array(expected_array)
    end
  end
end
