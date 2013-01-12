class Feedback < ActiveRecord::Base
  attr_accessible :user_id, :document_id, :accepted_by_user

  belongs_to :user
  belongs_to :document

end
