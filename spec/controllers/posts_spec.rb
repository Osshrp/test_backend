require "rails_helper"

module Api
  module V1
    describe PostsController, type: :request do
      # before do
      #   @user = User.create(
      #                       nickname: 'Test',
      #                       email: 'test@example.com',
      #                       password: '123456'
      #                      )
      # end
      let!(:user) { FactoryGirl.create(:user) }
      describe "GET #index" do
        # let!(@user) { FactoryGirl.create(:user) }
        let!(:posts) { FactoryGirl.create_list(:post, 2, user: user) }
        before { get api_v1_posts_url }

        it "has a 200 status code" do
          expect(response.status).to eq(200)
        end

        it "shows an array of all posts" do
          expect(JSON.parse(response.body)["data"][0]["attributes"]["title"])
            .to eq(posts[0]["title"])
          expect(JSON.parse(response.body)["data"][1]["attributes"]["title"])
            .to eq(posts[1]["title"])
        end
      end

      describe "POST #create" do
        let!(:post_obj) { FactoryGirl.create(:post, user: user) }
        it "creates the new post" do
          post api_v1_posts_url,
            params: {
                      "data": { 
                        "type": "posts",
                        "attributes": {
                          "title" => post_obj.title,
                          "body" => post_obj.body,
                        },
                        "relationships": {
                          "user": {
                            "data": {
                              "type": "users",
                              "id": user.id
                            }
                          }
                        }
                      }
                    }.to_json,
            headers: { "CONTENT_TYPE" => "application/vnd.api+json"}
          expect(response.content_type).to eq("application/vnd.api+json")
          expect(response.status).to eq(201)
        end
      end
    end
  end
end