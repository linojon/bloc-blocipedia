class WikiPolicy < ApplicationPolicy

  def show?
    !record.private? || (user && record.collaborators.include?(user))
  end

end