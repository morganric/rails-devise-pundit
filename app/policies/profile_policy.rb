class ProfilePolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    true
  end

  def index?
    @user.admin?
  end

  def update?
    @user.admin? || @user == current_user
  end

  def destroy?
    @user.admin?
  end

end
