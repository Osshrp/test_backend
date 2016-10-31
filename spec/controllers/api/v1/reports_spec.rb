require "rails_helper"

module Api
  module V1
    describe PostsController, type: :request do
      let(:user) { FactoryGirl.create(:user) }
      let(:posts) { FactoryGirl.create_list(:post, 2, user: user) }
      let(:headers) { { Authorization: "Token token=#{user.token}" } }
      before do
        post api_v1_reports_by_author_url, as: :json,
            params: { "report": 
                      {
                        "email": "test@example.com",
                        "start_date": posts[0].created_at,
                        "end_date": posts[0].created_at
                      }
                    },
            headers: headers
      end
      describe "POST #by_author" do
        it "has json content type and 200 status" do
          expect(response.content_type).to eq("application/json")
          expect(response.status).to eq(200)
        end

        it "creates the job" do
          expect(Delayed::Job.count).to eq(1)
        end

        it "returns: Report generation started" do
          expect(JSON.parse(response.body))
            .to include({"message" => "Report generation started"})
        end
      end
    end
  end
end
