class DocumentPolicy < Struct.new(:user, :document)

  def browse?
    user.present?
  end

  def create?
    user.present?
  end

  def create_feedback?
    user.present? && owned?
  end

  def destroy?
    user.present? && owned?
  end

  def edit?
    (user && document.user_id == user.id) || (user && user.admin?)
  end

  def feedback?
    feedback = document.feedbacks.find_by_user_id(user.id)
    owned? || (user && feedback.present? && feedback.accepted_by_user != false)
  end

  def feedback_complete?
    user && document.feedbacks.find_by_user_id(user.id).present?
  end

  def invite_volunteer?
    user.present? && owned?
  end

  def new?
    user.present?
  end

  def owned?
    user && document.user_id == user.id
  end

  def pay_for_document?
    user && owned?
  end

  def readers?
    user.present? && owned?
  end

  def reading?
    user.present?
  end

  def uninvite_volunteer?
    user.present? && owned?
  end

  def update?
    user && owned?
  end

  def volunteers?
    user.present? && owned?
  end

  def writing?
    user.present?
  end
end
