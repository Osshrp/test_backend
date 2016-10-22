require "rails_helper"

module Api
  module V1
    describe PostsController, type: :request do
      let(:post_obj) { FactoryGirl.create(:post, user: user) }
      let!(:user) { FactoryGirl.create(:user) }

      describe "GET #index" do
        # let!(@user) { FactoryGirl.create(:user) }
        let!(:posts) { FactoryGirl.create_list(:post, 2, user: user) }

        describe "unauthorized access" do

          it "has a 401 status code" do
            get api_v1_posts_url,
              params: {},
              headers: {Authorization: "Token token="}
            expect(response.status).to eq(401)
          end
        end

        describe "authorized access" do
          before do
            get api_v1_posts_url,
              params: { },
              headers: {Authorization: "Token token=#{user.token}"}
          end
          it "has a 200 status code" do
            expect(response.status).to eq(200)
          end

          it "has json content type" do
            expect(response.headers['Content-Type'])
              .to eq('application/json; charset=utf-8')
          end

        end

        describe "it has headers" do
          it "with total_entries" do
            get api_v1_posts_url,
            params: { page: "1" },
            headers: {Authorization: "Token token=#{user.token}"}
            expect(JSON.parse(response.headers["X-Pagination"])["total_entries"])
              .to eq(2)
          end

          it "with total_pages" do
            get api_v1_posts_url,
            params: { page: "1" },
            headers: {Authorization: "Token token=#{user.token}"}
            expect(JSON.parse(response.headers["X-Pagination"])["total_pages"])
              .to eq(1)
          end
        end
      end

      describe "POST #create" do
        it "creates the new post" do
          post api_v1_posts_url,
            params: { "post": 
                      {
                        "title": post_obj.title,
                        "body": post_obj.body,
                      }
                    }.to_json,
            headers: { 
                       "Content-Type" => "application/json",
                       Authorization: "Token token=#{user.token}"
                     }
          expect(response.content_type).to eq("application/json")
          expect(response.status).to eq(201)
          expect(JSON.parse(response.body)).to have_key("published_at")
        end

        it "returns array of errors" do
          post api_v1_posts_url,
            params: { "post": 
                      {
                        "title": post_obj.title
                      }
                    }.to_json,
            headers: { 
                       "Content-Type" => "application/json",
                       Authorization: "Token token=#{user.token}"
                     }
          expect(response.content_type).to eq("application/json")
          expect(JSON.parse(response.body)).to include({"body"=>["can't be blank"]})
        end
      end
    end
  end
end
