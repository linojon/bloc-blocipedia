class WikiPolicy < ApplicationPolicy

  def show?
    !record.private? || (user && record.collaborators.include?(user))
  end

  def create?
    user.present?
  end

  def update?
    user && record.collaborators.include?(user)
  end

  def destroy?
    user && user.role_for(record) == 'owner'
  end    

  def collaborators?
    update_collaborators?
  end
  
  def update_collaborators?
    user && user.role_for(record) == 'owner'
  end

end