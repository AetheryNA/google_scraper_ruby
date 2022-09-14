class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true, length: {minimum: 5}
  validates :password, presence: true, length: {minimum: 5}
  validates :password_confirmation, presence: true
end
