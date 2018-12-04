# Preview all emails at http://localhost:3000/rails/mailers/student_mailer
class StudentMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/student_mailer/info_status
  def info_status
    StudentMailer.info_status
  end

  # Preview this email at http://localhost:3000/rails/mailers/student_mailer/account_activation
  def account_activation
    StudentMailer.account_activation
  end

end
