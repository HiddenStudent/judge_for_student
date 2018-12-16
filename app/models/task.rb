
class Task < ApplicationRecord
  has_many :users
  has_many :task_groups, dependent: :destroy
  has_many :answers, dependent: :destroy
  validates :content, presence: true, length: { maximum: 200 }
  validates :name, presence: true, length: { minimum: 1, message: "only allows letters"}
  validates :content, presence: true, length: { minimum: 1, message: "only allows letters" }

  def users_in_task(task_id)
    ids = "SELECT user_id FROM answers
           WHERE task_id = #{task_id}"
    User.where("id IN (#{ids})")
  end
end
