class User < ApplicationRecord
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensative: false }
  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, on: :create

  enum role: { user: 0, admin: 1 }

  scope :search, ->(term) { where('username LIKE :param or email LIKE :param', param: "%#{term}%") }
end
