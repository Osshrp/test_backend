class Api::V1::ReportsController < ApplicationController
  before_action :authenticate
  before_action :load_users, only: :by_author

  def by_author
    ReportMailer.delay.by_author(report_params[:email], @users)
    render json: { message: "Report generation started" }
  end

  private

  def load_users
    @users = SelectUsers.select(report_params.to_h)
  end

  def report_params
    params.require(:report).permit(:start_date, :end_date, :email)
  end
end
