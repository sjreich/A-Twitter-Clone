class Relationship < ActiveRecord::Base
  belongs_to :loudspeaker, class_name: "User"
  belongs_to :listener, class_name: "User"
end
