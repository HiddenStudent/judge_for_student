
class Task < ApplicationRecord
  has_many :answers, dependent: :destroy
  validates :content, presence: true, length: { maximum: 1000 }
  validates :content, presence: true, length: { minimum: 1, message: "only allows letters" }
  validates :name, presence: true, length: { maximum: 50 }
  validates :name, presence: true, length: { minimum: 1, message: "only allows letters"}


  def users_in_task(task_id)
    ids = "SELECT user_id FROM answers
           WHERE task_id = #{task_id}"
    User.where("id IN (#{ids})")
  end
end
