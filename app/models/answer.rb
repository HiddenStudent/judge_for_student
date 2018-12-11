class Answer < ApplicationRecord
  has_many :studentanswers
  validates :content, presence: true, length: { maximum: 500 }

end



