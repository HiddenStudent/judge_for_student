class User < ApplicationRecord
  has_many :answers, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :picture, PictureUploader

  def activate
    update_columns(activated: true)
  end

  def generate_activation_digest!
    self.activation_digest = User.new_digest
  end

  def User.new_digest
    SecureRandom.urlsafe_base64
  end

  def tasks(task_id, user_id)
    ids = "SELECT task_id FROM answers
           WHERE user_id = #{user_id} AND task_id = #{task_id}"
    Task.where("id IN (#{ids})").first
  end

  def u_answers(user_id, task_id)
    ids = "SELECT id FROM answers
           WHERE user_id = #{user_id} AND task_id = #{task_id}"
    Answer.where("id IN (#{ids})").first
  end
end
