class Feedback < ActiveRecord::Base
  attr_accessible :user_id, :document_id
  #
  belongs_to :user
  belongs_to :document

end
