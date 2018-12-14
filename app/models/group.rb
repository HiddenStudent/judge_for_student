class Group < ApplicationRecord
  has_many :task_groups
  validates :name,  presence: true, length: { maximum: 50 }
  validates :name,  presence: true, length: { minimum: 1 }

  def show_tasks(group_id)
    ids = "SELECT task_id FROM task_groups
           WHERE group_id = #{group_id}"
    Task.where("id IN (#{ids})")
  end

  def gr_tasks(group_id)
    ids = "SELECT id FROM task_groups
           WHERE group_id = #{group_id}"
    TaskGroup.where("id IN (#{ids})")
  end

end
