class StudentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_mailer.info_status.subject
  #
  def info_status(user)
    @user = user

    mail to: user.email, subject: "Information about task"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_mailer.account_activation.subject
  #
  def account_activation
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def new_task_notify(user)
    @user = user

    mail to: user.email, subject: "Information about task"
  end
end
