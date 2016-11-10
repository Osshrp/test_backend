class Api::V1::ReportsController < ApplicationController
  before_action :authenticate

  def by_author
    GenerateReportJob.perform_later(report_params.to_h)
    render json: { message: "Report generation started" }
  end

  private

  def report_params
    params.require(:report).permit(:start_date, :end_date, :email)
  end
end
