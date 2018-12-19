class StudentMailer < ApplicationMailer

  def info_status(user, text, answer)
    @answer = answer
    @user = user
    @text = text
    mail to: user.email, subject: 'Information about task'
  end

  def new_group_notify(user, group)
    @user = user
    @group = group
    mail to: user.email, subject: 'Information about task'
  end

  def activation(user)
    @user = user

    mail to: user.email, subject: 'Activation account'
  end

end
