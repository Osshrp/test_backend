class ApplicationMailer < ActionMailer::Base
  default from: 'app0@heroku.com'
  layout 'mailer'
end
