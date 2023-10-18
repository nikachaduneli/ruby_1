class User < ApplicationRecord

  before_save {self.email = email.downcase}
  has_many :articles, dependent: :delete_all
  has_one_attached  :profile_pic


  validates :username,
            presence: true,
            length: {minimum: 5, maximum: 20},
            uniqueness: { case_sensitive: false }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            presence: true,
            length: {minimum: 5, maximum: 40},
            uniqueness: { case_sensitive: false },
            confirmation: true,
            format: {with: VALID_EMAIL_REGEX}
  validates :password_digest, confirmation: true
  has_secure_password

  self.per_page = 5
end
