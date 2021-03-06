class Group < ApplicationRecord
  has_many :task_groups, dependent: :destroy
  has_many :group_users, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 50 }
  validates :name,  presence: true, length: { minimum: 1 }

  def show_tasks(group_id)
    ids = "SELECT task_id FROM task_groups
           WHERE group_id = #{group_id}"
    Task.where("id IN (#{ids})")
  end
end
