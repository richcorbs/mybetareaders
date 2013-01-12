class FeedbackPolicy < Struct.new(:user, :feedback)

  def create?
    user.present?
  end

  def decline_invitation?
    user.present? && feedback.user == user
  end

  def destroy?
    user.present? && feedback.document.user == user
  end

  def set_bookmark?
    user && feedback.user == user
  end

end
