class Answer < ApplicationRecord
  belongs_to :users, optional: true
end
