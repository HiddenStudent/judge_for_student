class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :picture, PictureUploader

  has_many :studentanswers

  def activate
    update_columns(activated: true)
  end

  def new_token
    SecureRandom.urlsafe_base64
  end

  def tasks(task_id, user_id)
    ids = "SELECT task_id FROM studentanswers
           WHERE user_id = #{user_id} AND task_id = #{task_id}"
    Atask.where("id IN (#{ids})").first
  end

  def student_task_user(task_id,user_id)
    ids = "SELECT id FROM studentanswers
           WHERE studentanswers.user_id = #{user_id} AND studentanswers.task_id = #{task_id}"
    Studentanswer.where("id IN (#{ids})").first
  end

  def tasks_user(user_id)
    ids = "SELECT id FROM studentanswers
           WHERE studentanswers.user_id = #{user_id}"
    Studentanswer.where("id IN (#{ids})")
  end
end
