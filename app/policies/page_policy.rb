class PagePolicy < Struct.new(:user, :user2)

  def create?
    user && user.admin?
  end

  def destroy?
    user && user.admin?
  end

  def edit?
    user && user.admin?
  end

  def home?
    true
  end

  def index?
    user && user.admin?
  end

  def new?
    user && user.admin?
  end

  def public?
    true
  end

  def update?
    user && user.admin?
  end

end
