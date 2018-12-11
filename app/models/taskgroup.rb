class Taskgroup < ApplicationRecord
  has_one :group
  has_one :atask
end
