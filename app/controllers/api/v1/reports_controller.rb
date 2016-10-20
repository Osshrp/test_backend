class Api::V1::ReportsController < ApplicationController
  before_action :authenticate


  def by_author
    users = SortUsers.sort(report_params)
    ReportMailer.by_author(JSON.parse(report_params.to_json), users).deliver_now
    render json: "Report generation started"
  end

  private

  def report_params
    params.require(:report).permit(:start_date, :end_date, :email)
  end
end