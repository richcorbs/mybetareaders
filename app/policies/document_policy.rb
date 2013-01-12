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
    owned? || (user && document.feedbacks.find_by_user_id(user.id).present?)
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

  def readers?
    user.present? && owned?
  end

  def reading?
    user.present?
  end

  def uninvite_volunteer?
    user.present? && owned?
  end

  def volunteers?
    user.present? && owned?
  end

  def writing?
    user.present?
  end
end
