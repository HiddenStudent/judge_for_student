class Answer < ApplicationRecord
  belongs_to :users, optional: true
  validates :content, presence: true, length: { maximum: 500 }

end



