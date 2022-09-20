# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # the authenticate method from devise documentation
  def self.authenticate(email, password)
    password_param = password

    user = User.find_for_authentication(email: email)
    user&.valid_password?(password_param) ? user : nil
  end
end
