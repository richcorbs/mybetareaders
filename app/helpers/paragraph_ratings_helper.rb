module ParagraphRatingsHelper
  def button_class rating, criterium, direction
    if rating.ratings.present?
      if rating.ratings[criterium] && rating.ratings[criterium] == "1" && direction == 'up'
        'btn-success'
      elsif rating.ratings[criterium] && rating.ratings[criterium] == "-1" && direction == 'down'
        'btn-danger'
      end
    end
  end
end
