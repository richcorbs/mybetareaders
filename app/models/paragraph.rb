class Paragraph < ActiveRecord::Base
  attr_accessible :text, :user_id, :document_id
  belongs_to :document
  has_many :paragraph_comments, :dependent => :destroy
  has_many :paragraph_ratings, :dependent => :destroy

  # pace, flow, grammar, clarity/focus, logical, interesting/engaging, organization, voice, simple/concise, variety

  def rating_by_user( user )
    ParagraphRating.find_or_create_by_paragraph_id_and_user_id(self.id, user.id)
  end

  def thumbs_up_ratings( which = 'all')
    count = 0
    self.paragraph_ratings.each do |rating| 
      if rating.ratings.present?
        Criterium.ordered_by_alpha.each do |criterium|
          if which == 'all' || which == criterium.criterium
            count += 1 if (rating.ratings[criterium.criterium].present? && rating.ratings[criterium.criterium] == "1")
          end
        end
      end
    end
    count
  end

  def thumbs_down_ratings( which = 'all' )
    count = 0
    self.paragraph_ratings.each do |rating|
      if rating.ratings.present?
        Criterium.ordered_by_alpha.each do |criterium|
          if which == 'all' || which == criterium.criterium
            count += 1 if (rating.ratings[criterium.criterium].present? && rating.ratings[criterium.criterium] == "-1")
          end
        end
      end
    end
    count
  end
end
