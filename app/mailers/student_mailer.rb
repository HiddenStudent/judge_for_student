class StudentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_mailer.info_status.subject
  #
  def info_status(user,text,answer)
    @answer = answer
    @user = user
    @text = text
    mail to: user.email, subject: "Information about task"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_mailer.account_activation.subject


  def new_task_notify(user,task)
    @user = user
    @task = task
    mail to: user.email, subject: "Information about task"
  end

  def activation(user)
    @user = user

    mail to: user.email, subject: "Test"
  end

end
