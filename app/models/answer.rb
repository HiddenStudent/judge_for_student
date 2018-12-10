class Answer < ApplicationRecord
  belongs_to :users, optional: true
  has_many :studentanswers
  validates :content, presence: true, length: { maximum: 500 }

end



