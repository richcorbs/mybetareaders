class ParagraphRating < ActiveRecord::Base
  attr_accessible :rating_character, :rating_pace, :rating_plot, :rating_grammar, :paragraph_id, :user_id
  belongs_to :paragraph
  belongs_to :user

  serialize :ratings, ActiveRecord::Coders::Hstore

  def update_from_params params
    if (self.ratings[params[:criterium]] && self.ratings[params[:criterium]] == "1" && params[:direction] == 'up') || (self.ratings[params[:criterium]] && self.ratings[params[:criterium]] == "-1" && params[:direction] == 'down')
      self.ratings[params[:criterium]] = "0" 
    else
      self.ratings[params[:criterium]] = params[:direction] == 'up' ? "1" : "-1"
    end
    self.save
  end

end
