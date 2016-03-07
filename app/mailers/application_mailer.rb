class ApplicationMailer < ActionMailer::Base
  default from: "exohedron@gmail.com"
  layout 'mailer'
  include SendGrid
end
