class Taskgroup < ApplicationRecord
  belongs_to :group
  has_one :atask
end
