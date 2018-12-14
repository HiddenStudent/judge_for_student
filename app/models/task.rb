
class Task < ApplicationRecord
  has_many :users
  has_many :task_groups,dependent: :destroy
  #belongs_to :tasks_group
  #has_one :answer
  has_many :student_answers, dependent: :destroy
  validates :content, presence: true, length: { maximum: 200 }
  validates :name, presence: true, length: { minimum: 1, message: "only allows letters"}
  validates :content, presence: true, length: { minimum: 1, message: "only allows letters" }

  def users_in_task(task_id)
    ids = "SELECT user_id FROM student_answers
           WHERE task_id = #{task_id}"
    User.where("id IN (#{ids})")
  end

  def studentanswers(task_id, user_id)
    StudentAnswer.where("id IN (SELECT id FROM student_answers
                    WHERE task_id = #{task_id} AND user_id = #{user_id})").first
  end

  def finals
    ids = "SELECT id FROM studentanswers
           WHERE status = #{complete}"
    StudentAnswer.where("id IN (#{ids})")
  end
end
