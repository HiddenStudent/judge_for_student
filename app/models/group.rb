class Group < ApplicationRecord
  has_many :taskgroups
  validates :name,  presence: true, length: { maximum: 50 }

  def show_tasks(group_id)
    ids = "SELECT task_id FROM taskgroups
           WHERE group_id = #{group_id}"
    Atask.where("id IN (#{ids})")
  end

end
