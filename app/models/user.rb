class User < ApplicationRecord
  before_save {email.downcase!}
  validates :name, presence: true, length: {minimum: Settings.users.name.min_length, maximum: Settings.users.name.max_length} # warning: it's must be { maximum:50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /[A-Z][a-z]\d/i
  validates :email, presence: true, length: {maximum: Settings.users.email.max_length}, format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true, length: {minimum: Settings.users.password.min_length, maximum: Settings.users.password.max_length}, format: {with: VALID_PASSWORD_REGEX}
  has_secure_password
end
