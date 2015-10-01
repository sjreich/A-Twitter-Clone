class User < ActiveRecord::Base
  has_secure_password

  validates :name,        presence: true,
                          length: {maximum: 55}

  email_regex = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
  validates :email,       presence: true,
                          length: {maximum: 255},
                          uniqueness: {case_sensitive: false},
                          format: {with: email_regex}

  validates :password,    presence: true,
                          length: {minimum: 6},
                          allow_nil: true
end
