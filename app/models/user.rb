class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :picture, PictureUploader

  has_many :student_answers

  def activate
    update_columns(activated: true)
  end

  def generate_activation_digest!
    self.activation_digest = User.new_digest
   # @user.activation_digest = SecureRandom.urlsafe_base64
  end

  def User.new_digest
    SecureRandom.urlsafe_base64
  end

  def tasks(task_id, user_id)
    ids = "SELECT task_id FROM student_answers
           WHERE user_id = #{user_id} AND task_id = #{task_id}"
    Task.where("id IN (#{ids})").first
  end

  def student_task_user(task_id,user_id)
    ids = "SELECT id FROM student_answers
           WHERE user_id = #{user_id} AND task_id = #{task_id}"
    StudentAnswer.where("id IN (#{ids})").first
  end

  def tasks_user(user_id)
    ids = "SELECT id FROM student_answers
           WHERE student_answers.user_id = #{user_id}"
    StudentAnswer.where("id IN (#{ids})")
  end
end
