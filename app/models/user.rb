class User < ApplicationRecord
  validates :name, presence: true
  has_secure_password
  enum status: { normal: 0, disabled: 9, admin: 10, admin_disabled: 19 }

  def self.digest(str)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(str, cost: cost)
  end
end
