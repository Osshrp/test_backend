require 'rails_helper'

RSpec.describe GenerateReportJob, type: :job do
  it "matches with enqueued job" do
    ActiveJob::Base.queue_adapter = :test
    expect {
      GenerateReportJob.perform_later
    }.to have_enqueued_job(GenerateReportJob)
  end
end
