require "rails_helper"

module Api
  module V1
    describe PostsController, type: :request do
      let(:post_obj) { FactoryGirl.create(:post, user: user) }
      let!(:user) { FactoryGirl.create(:user) }
      let!(:headers) { { Authorization: "Token token=#{user.token}" } }

      describe "GET #index" do
        let!(:posts) { FactoryGirl.create_list(:post, 2, user: user) }
        describe "unauthorized access" do

          it "has a 401 status code" do
            get api_v1_posts_url, as: :json
            expect(response.status).to eq(401)
          end
        end

        describe "authorized access" do
          before do
            get api_v1_posts_url, as: :json, headers: headers
          end

          it "has a 200 status code" do
            expect(response.status).to eq(200)
          end

          it "has json content type" do
            expect(response.headers['Content-Type'])
              .to eq('application/json; charset=utf-8')
          end

          it "has fields: id, title, body, published_at, author_nickname, comments" do
            expect((JSON.parse(response.body)).first.keys)
              .to contain_exactly("id",
                                  "title",
                                  "body",
                                  "published_at",
                                  "author_nickname",
                                  "comments")
          end
        end

        describe "it has headers" do
          before do
            get api_v1_posts_url, as: :json,
            params: { page: "1" }, headers: headers
          end
          it "with total_entries" do
            expect(JSON.parse(response.headers["X-Pagination"])["total_entries"])
              .to eq(2)
          end

          it "with total_pages" do
            expect(JSON.parse(response.headers["X-Pagination"])["total_pages"])
              .to eq(1)
          end
        end
      end

      describe "GET #show" do
        before do
          get "#{api_v1_posts_url}/#{post_obj.id}", as: :json, headers: headers
        end

        it "it has status 200" do
          expect(response.status).to eq(200)
        end

        it "has fields: id, title, body, published_at, author_nickname, comments" do
          expect(JSON.parse(response.body).keys)
            .to contain_exactly("id",
                                "title",
                                "body",
                                "published_at",
                                "author_nickname",
                                "comments")
        end
      end

      describe "POST #create" do
        it "creates the new post" do
          post api_v1_posts_url, as: :json,
            params: { "post": 
                      {
                        "title": post_obj.title,
                        "body": post_obj.body,
                      }
                    },
            headers: headers

          expect(response.status).to eq(201)
          expect(JSON.parse(response.body)).to have_key("published_at")
        end

        it "returns array of errors" do
          post api_v1_posts_url, as: :json,
            params: { "post": 
                      {
                        "title": post_obj.title
                      }
                    },
            headers: headers

          expect(JSON.parse(response.body))
            .to include({"errors" => {"body"=>["can't be blank"]}})
        end
      end
    end
  end
end
