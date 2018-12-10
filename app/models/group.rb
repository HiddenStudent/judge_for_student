class Group < ApplicationRecord
  has_many :taskgroups
  validates :name,  presence: true, length: { maximum: 50 }

end
