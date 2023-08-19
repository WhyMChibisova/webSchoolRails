class UserPolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    user&.student? || user&.teacher? || user&.admin?
  end

  def create?
    !(user&.student? || user&.teacher? || user&.admin?)
  end

  def new?
    create?
  end

  def update?
    record == user || user&.admin?
  end

  def edit?
    update?
  end

  def destroy?
    record == user
  end
end
