class GenerateReportJob < ApplicationJob
  queue_as :default

  def perform(params)
    users = User.select_users(params)
    ReportMailer.delay.by_author(params[:email], users)
  end
end
