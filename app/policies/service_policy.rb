class ServicePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    user&.approved_provider? || user&.admin?
  end

  def create?
    new?
  end

  def edit?
    (user&.approved_provider? && record.user == user) || user&.admin?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def add_tag?
    edit?
  end

  def remove_tag?
    edit?
  end
end
