  class Admin::UserPolicy < ApplicationPolicy

    def index?
      user&.admin?
    end

    def show?
      user&.admin?
    end

    def create?
      user&.admin?
    end

    def new?
      create?
    end

    def update?
      user&.admin?
    end

    def edit?
      update?
    end

    def destroy?
      user&.admin? && !record.admin?
    end

    def sort?
      user&.admin?
    end

  end
