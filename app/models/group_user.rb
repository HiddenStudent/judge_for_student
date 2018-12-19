class GroupUser < ApplicationRecord
  has_one :group
  def users_in_task(task_id)
    ids = "SELECT user_id FROM answers
           WHERE task_id = #{task_id}"
    User.where("id IN (#{ids})")
  end
end
