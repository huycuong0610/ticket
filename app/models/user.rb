class User < ActiveRecord::Base
  has_many :events

  has_secure_password
  mount_uploader :avatar, ImageUploader
  validates :password, length: {minimum: 8}, presence: true, allow_nil: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true,
            format: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
end