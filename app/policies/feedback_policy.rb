class FeedbackPolicy < Struct.new(:user, :feedback)

  def create?
    true
  end

  def destroy?
    user.present? && feedback.document.user == user
  end

  def new?
    true
  end

end
