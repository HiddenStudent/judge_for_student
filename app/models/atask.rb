
class Atask < ApplicationRecord
  has_many :users
  #belongs_to :tasks_group
  validates :content, presence: true, length: { maximum: 200 }
end
