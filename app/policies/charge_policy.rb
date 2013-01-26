class ChargePolicy < Struct.new(:user, :charge)

  def index?
    user && user.admin? 
  end

end
