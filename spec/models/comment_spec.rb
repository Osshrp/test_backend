require 'rails_helper'

describe Comment, type: :model do
  it { should belong_to :post }
  it { should validate_presence_of :body }
end
