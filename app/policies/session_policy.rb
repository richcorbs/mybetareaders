class SessionPolicy < Struct.new(:user, :user2)

  def create?
    true
  end

  def destroy?
    user
  end

  def new?
    true
  end

end
