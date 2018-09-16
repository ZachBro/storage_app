class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 25 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  before_save { self.name = name.upcase }
end
