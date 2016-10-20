class Api::V1::ReportsController < ApplicationController
  before_action :authenticate


  def by_author
    users = SortUsers.sort(report_params)
    ReportMailer.delay.by_author(report_params[:email], users)
    render json: "Report generation started"
  end

  private

  def report_params
    params.require(:report).permit(:start_date, :end_date, :email)
  end
end