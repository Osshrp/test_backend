class ReportMailer < ApplicationMailer

  def by_author(email, users)
    @users = users
    mail(to: email, subject: 'Analitic report')
  end
end
