class Taskgroup < ApplicationRecord
  #has_many :atasks
  belongs_to :group
  has_one :atask
end
