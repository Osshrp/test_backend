class ReportMailer < ApplicationMailer

  def by_author(params, users)
    @params = params
    @users = users
    mail(to: params["email"], subject: 'Analitic reporpt')
  end
end
