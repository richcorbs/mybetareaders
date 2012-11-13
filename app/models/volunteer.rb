class Volunteer < ActiveRecord::Base
  attr_accessible :document_id, :user_id, :invited

  belongs_to :user
  belongs_to :document
end
