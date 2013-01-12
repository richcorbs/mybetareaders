class FeedbackPolicy < Struct.new(:user, :feedback)

  def create?
    user.present?
  end

  def destroy?
    user.present? && feedback.document.user == user
  end

end
