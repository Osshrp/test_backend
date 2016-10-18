class ReportMailer < ApplicationMailer

  def by_author(params)
    @params = params
    users = User.all
    mail(to: params["email"], subject: 'Analitic reporpt')
  end
end
