class Api::V1::ReportsController < ApplicationController
  before_action :authenticate

  def by_author
    users = SelectUsers.select(report_params.to_h)
    ReportMailer.delay.by_author(report_params[:email], users)
    render json: "Report generation started\n"
  end

  private

  def report_params
    params.require(:report).permit(:start_date, :end_date, :email)
  end
end
