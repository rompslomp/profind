class QuotePolicy < ApplicationPolicy
  def show?
    record.user == user || record.service.user == user || user&.admin?
  end

  def destroy?
    record.user == user || user&.admin?
  end
end
