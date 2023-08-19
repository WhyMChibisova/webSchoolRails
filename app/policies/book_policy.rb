class BookPolicy < ApplicationPolicy
  def index?
    user&.student? || user&.teacher? || user&.admin?
  end

  def show?
    user&.student? || user&.teacher? || user&.admin?
  end

  def create?
    user&.teacher? || user&.admin?
  end

  def new?
    create?
  end

  def update?
    user&.teacher? || user&.admin?
  end

  def edit?
    update?
  end

  def destroy?
    user&.teacher? || user&.admin?
  end

  def sort?
    user&.student? || user&.teacher? || user&.admin?
  end
end
