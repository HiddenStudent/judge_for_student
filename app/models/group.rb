class Group < ApplicationRecord
  has_many :taskgroups
  validates :name,  presence: true, length: { maximum: 50 }
  validates :name,  presence: true, length: { minimum: 1 }

  def show_tasks(group_id)
    ids = "SELECT task_id FROM taskgroups
           WHERE group_id = #{group_id}"
    Atask.where("id IN (#{ids})")
  end

  def gr_tasks(group_id)
    ids = "SELECT id FROM taskgroups
           WHERE group_id = #{group_id}"
    Taskgroup.where("id IN (#{ids})")
  end

end
