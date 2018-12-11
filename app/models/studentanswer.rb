class Studentanswer < ApplicationRecord
  has_one :user
  has_one :answer

  def answers(task_id)
    ids = "SELECT answer_id FROM studentanswers
           WHERE task_id = #{task_id}"
    Answer.where("id IN (#{ids})")
  end

  def stanswers(task_id)
    ids = "SELECT id FROM studentanswers
           WHERE task_id = #{task_id}"
    Studentanswer.where("id IN (#{ids})")
  end

end
