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

  has_many :messages

  has_many :listenings, class_name: "Relationship",
                        foreign_key: "listener_id",
                        dependent: :destroy
  has_many :loudspeakers, through: :listenings

  has_many :loudspeakings,  class_name: "Relationship",
                            foreign_key: "loudspeaker_id",
                            dependent: :destroy
  has_many :listeners, through: :loudspeakings

  def follow(other_user)
    listenings.create(loudspeaker_id: other_user.id)
  end

  def unfollow(other_user)
    listenings.find_by(loudspeaker_id: other_user.id).destroy
  end

  def following?(other_user)
    loudspeakers.include?(other_user)
  end

end
