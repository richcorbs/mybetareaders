class DocumentPolicy < Struct.new(:user, :document)

  def owned?
    user && document.user_id == user.id
  end

  def feedback?
    owned? || (user && document.feedbacks.find_by_user_id(user.id).present?)
  end

  def feedback_complete?
    user && document.feedbacks.find_by_user_id(user.id).present?
  end

  def invite_volunteer?
    user.present? && owned?
  end

  def readers?
    user.present? && owned?
  end

  def reading?
    user.present?
  end

  def volunteers?
    user.present? && owned?
  end

  def whats_hot?
    user.present?
  end

  def writing?
    user.present?
  end
end
