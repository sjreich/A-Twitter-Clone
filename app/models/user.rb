class User < ActiveRecord::Base
  has_secure_password

  validates :name,    presence: true,
                      length: {maximum: 50}

  email_regex = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/
  validates :email,   presence: true,
                      length: {maximum: 255},
                      uniqueness: {case_sensitive: false},
                      format: {with: email_regex}

  validates :password, length: {minimum: 6} 
end
