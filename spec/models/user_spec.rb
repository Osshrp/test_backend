require 'rails_helper'

describe User, type: :model do
  it { should have_many :posts }
  it { should have_many :comments }

  # it { should validate_presence_of :nickname }
  # it { should validate_presence_of :email }
  # it { should validate_presence_of :password }
end