class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  #validates :task_id, presence: true
  has_many :studentanswers
  mount_uploader :picture, PictureUploader

  def activate
    update_columns(activated: true)
  end

  def new_token
    SecureRandom.urlsafe_base64
  end
end
