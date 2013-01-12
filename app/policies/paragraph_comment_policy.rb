class ParagraphCommentPolicy < Struct.new(:user, :paragraph_comment)

  def create?
    feedback = paragraph_comment.paragraph.document.feedbacks.find_by_user_id(user.id)
    user && (paragraph_comment.paragraph.document.user == user || (feedback.present? && feedback.accepted_by_user == true))
  end

end
