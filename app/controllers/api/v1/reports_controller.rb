class Api::V1::ReportsController < ApplicationController
  # include ActionView::Layouts
  before_action :authenticate

  def by_author
    # @params = report_params
    ReportMailer.delay.by_author(JSON.parse(report_params.to_json))
    # GenerateReport.start(JSON.parse(report_params.to_json))
    render json: "Report generation started"
  end

  private

  def report_params
    params.require(:report).permit(:start_date, :end_date, :email)
  end
end