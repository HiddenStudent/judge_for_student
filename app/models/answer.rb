class Answer < ApplicationRecord
  #has_many :studentanswers
  validates :content, presence: true, length: { maximum: 500 }
  validates :content, presence: true, length: { minimum: 1 }


end



