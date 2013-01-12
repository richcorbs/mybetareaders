class ParagraphRatingPolicy < Struct.new(:user, :paragraph_rating)

  def create_or_update?
    user && paragraph_rating.user == user
  end

end
