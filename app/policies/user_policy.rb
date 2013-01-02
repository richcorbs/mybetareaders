class UserPolicy < Struct.new(:user, :user2)

  def edit?
    user == user2 ||  (user && user.admin?)
  end

  def index?
    user && user.admin?
  end

  def new?
    true
  end

  def preferences?
    user == user2
  end

  def preferences_update?
    user == user2
  end

  def show?
    user && user.admin?
  end

  def update?
    user == user2 ||  (user && user.admin?)
  end

end
