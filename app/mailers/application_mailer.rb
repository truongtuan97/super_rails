class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@super-rails.local'
  layout 'mailer'
end
