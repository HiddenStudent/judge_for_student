class StudentMailer < ApplicationMailer

  def info_status(user, text, answer)
    @answer = answer
    @user = user
    @text = text
    mail to: user.email, subject: 'Information about task'
  end

  def new_task_notify(user, task)
    @user = user
    @task = task
    mail to: user.email, subject: 'Information about task'
  end

  def activation(user)
    @user = user

    mail to: user.email, subject: 'Activation account'
  end

end
