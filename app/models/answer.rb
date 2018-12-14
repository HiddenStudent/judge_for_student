class Answer < ApplicationRecord
  validates :text, presence: true, length: { maximum: 500 }
  validates :text, presence: true, length: { minimum: 1 }

  has_one :user
  #belongs_to :answer,dependent: :destroy
  has_one :task
  def answers(task_id)
    ids = "SELECT answer_id FROM student_answers
           WHERE task_id = #{task_id}"
    Answer.where("id IN (#{ids})")
  end

  def u_answers(user_id)
    ids = "SELECT answer_id FROM student_answers
           WHERE user_id = #{user_id}"
    Answer.where("id IN (#{ids})")
  end

  def stanswers(task_id)
    ids = "SELECT id FROM student_answers
           WHERE task_id = #{task_id}"
    Answer.where("id IN (#{ids})")
  end

end
