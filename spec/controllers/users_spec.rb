require "rails_helper"

module Api
  module V1
    describe UsersController, type: :request do
      # let(:post_obj) { FactoryGirl.create(:post, user: user) }
      let(:user) { FactoryGirl.create(:user) }
      before do
        get user_url user
      end
      describe "USER #show" do
        it "return status 200" do
          expect(response.status).to eq(200)
        end

        it "renders user profile" do
          expect(response.body).to include "Your avatar"
        end
      end
    end
  end
end
