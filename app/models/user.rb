

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #validates :task_id, presence: true
belongs_to :atasks, optional: true
belongs_to :answers, optional:true

  def authenticated?(user)
    if user.teacher = true
      return true
    else
      return false
    end


  end
end
