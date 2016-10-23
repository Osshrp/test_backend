require "rails_helper"

module Api
  module V1
    describe PostsController, type: :request do
      let!(:user) { FactoryGirl.create(:user) }
      describe "POST #by_author" do
        it "creates the job" do
          post api_v1_reports_by_author_url,
            params: { "report": 
                      {
                        "email": "test@example.com",
                        "start_date": "2016-10-15",
                        "end_date": "2016-10-16"
                      }
                    }.to_json,
            headers: { 
                       "Content-Type" => "application/json",
                       Authorization: "Token token=#{user.token}"
                     }
          expect(response.content_type).to eq("application/json")
          expect(response.status).to eq(200)
          expect(Delayed::Job.count).to eq(1)
        end
      end
    end
  end
end