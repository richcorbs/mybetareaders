class ParagraphComment < ActiveRecord::Base
  attr_accessible :comment, :paragraph_id, :user_id
  belongs_to :paragraph
  belongs_to :document
  belongs_to :user
end
