module Api
  module V1
    describe UsersController, type: :request do
      # let(:post_obj) { FactoryGirl.create(:post, user: user) }
      # let!(:user) { FactoryGirl.create(:user) }

      describe "USER #create" do
        it "creates the new user" do
          post api_v1_users_url, as: :json,
            params: { "user": 
                      {
                        "nickname": "Nicky",
                        "email": "user@example.com",
                        "password": "123456"
                      }
                    }
          expect(response.content_type).to eq("application/json")
          expect(response.status).to eq(201)
        end
      end
    end
  end
end
