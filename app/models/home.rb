class Home < ApplicationRecord
  has_many :users
  enum status: { normal: 0, disabled: 9, admin: 10, admin_disabled: 19 }
end
