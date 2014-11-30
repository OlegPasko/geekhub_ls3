class UserMailer < ActionMailer::Base
  default from: "oleg@testapp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(email, name)
    @name = name

    mail to: email, subject: 'Welcome to testapp'
  end
end
