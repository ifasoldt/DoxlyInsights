class User < ApplicationRecord
  has_secure_password
  has_many :votes

  validates :email, uniqueness: true
  validates :password, length: {minimum: 6}, on: :create

end
