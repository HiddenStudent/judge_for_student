class Studentanswer < ApplicationRecord
  belongs_to :user
  has_one :answer
end
