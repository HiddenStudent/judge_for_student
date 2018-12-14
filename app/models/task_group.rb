class TaskGroup < ApplicationRecord
  has_one :group
  has_one :task
end
