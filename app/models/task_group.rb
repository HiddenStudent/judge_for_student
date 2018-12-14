class TaskGroup < ApplicationRecord
  has_one :group
  belongs_to :task, foreign_key: 'task_id', dependent: :destroy
end
