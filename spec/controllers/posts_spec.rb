require "rails_helper"

module Api
  module V1
    describe PostsController, type: :request do
      let(:post_obj) { FactoryGirl.create(:post, user: user) }
      let!(:user) { FactoryGirl.create(:user) }

      describe "GET #index" do
        # let!(@user) { FactoryGirl.create(:user) }
        let!(:posts) { FactoryGirl.create_list(:post, 2, user: user) }
        before { get api_v1_posts_url }

        it "has a 200 status code" do
          expect(response.status).to eq(200)
        end

        it "shows an array of all posts" do
          byebug
          JSON.parse(response.body).each_with_index do |body, index|
            expect(body["title"]).to eq(posts[index]["title"])
          end
        end
      end

      # describe "POST #create" do
      #   # let!(:post_obj) { FactoryGirl.create(:post, user: user) }
      #   it "creates the new post" do
      #     post api_v1_posts_url,
      #       params: {
      #                "title" => post_obj.title,
      #                "body" => post_obj.body,
      #               },
      #                   "relationships": {
      #                     "user": {
      #                       "data": {
      #                         "type": "users",
      #                         "id": user.id
      #                       }
      #                     }
      #                   }
      #                 }
      #               }.to_json,
      #       headers: { "CONTENT_TYPE" => "application/vnd.api+json"}
      #     expect(response.content_type).to eq("application/vnd.api+json")
      #     expect(response.status).to eq(201)
      #   end
      # end

      # describe "PUT #update" do
      #   it "changes post title" do
      #     patch api_v1_post_path(post_obj.id),
      #       params:
      #         {
      #           "data": {
      #             "id": post_obj.id,
      #             "type": "posts",
      #             "attributes": {
      #               "title" => "new title",
      #             }
      #           }
      #         }.to_json,
      #       headers: { "CONTENT_TYPE" => "application/vnd.api+json"}
      #     expect(JSON.parse(response.body)["data"]["attributes"]["title"]).to eq "new title"
      #   end
      # end

      # describe "DELETE #destroy" do
      #   it "deletes post" do
          
      #     expect { delete api_v1_post_path(post_obj) }.
      #       to change(Post, :count).by(-1)
      #   end
      # end
    end
  end
end
