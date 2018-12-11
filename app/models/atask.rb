
class Atask < ApplicationRecord
  has_many :users
  #belongs_to :tasks_group
  has_one :answer
  validates :content, presence: true, length: { maximum: 200 }

  def users_in_task(task_id)
    ids = "SELECT user_id FROM studentanswers
           WHERE task_id = #{task_id}"
    User.where("id IN (#{ids})")
  end

  def studentanswers(task_id, user_id)
    Studentanswer.where("id IN (SELECT id FROM studentanswers
                                 WHERE task_id = #{task_id} AND user_id = #{user_id} LIMIT 1) ").first
  end

  def finals
    ids = "SELECT id FROM studentanswers
           WHERE status = #{complete}"
    Studentanswer.where("id IN (#{ids})")
  end
end
