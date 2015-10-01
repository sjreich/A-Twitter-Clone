class User < ActiveRecord::Base
  has_secure_password

  validates name:         presence: true,
                          length: {maximum: 55}

  validates email:        presence: true,
                          length: {maximum: 255}
                          uniqueness: {case_sensitive: false}

  validates password:     presence: true,
                          length: {minumum: 6}
end
