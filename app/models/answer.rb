class Answer < ApplicationRecord

  has_one :user
  has_one :task

  def u_answers(user_id)
    ids = "SELECT answer_id FROM answers
           WHERE user_id = #{user_id}"
    Answer.where("id IN (#{ids})")
  end



end
