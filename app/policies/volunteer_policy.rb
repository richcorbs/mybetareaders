class VolunteerPolicy < Struct.new(:user, :user2)

  def create?
    user
  end

  def destroy?
    user
  end

end
