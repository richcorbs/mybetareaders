class ParagraphComment < ActiveRecord::Base
  attr_accessible :comment, :paragraph_id, :user_id
  belongs_to :paragraph
  belongs_to :document
  belongs_to :user

  scope :user_ids_in, lambda { |*ids| where(:user_id => ids.flatten.map(&:to_s)) }

end
