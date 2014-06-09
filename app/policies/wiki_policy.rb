class WikiPolicy < ApplicationPolicy

  def show?
    !record.private? || (user && record.collaborators.include?(user))
  end

  def create?
    user.present?
  end

  def update?
    user && user.role_for(record) == 'owner'
  end

end