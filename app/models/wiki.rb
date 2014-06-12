class Wiki < ActiveRecord::Base
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :user

  validates :title, presence: true, uniqueness: true
  before_validation :premium_only_privacy

  extend FriendlyId
  friendly_id :title, use: :slugged

  scope :not_private, -> { where(private: false) }
  scope :is_private,  -> { where(private: true) }

  def owner
    collab = collaborations.detect {|c| c.role == 'owner' }
    collab && collab.user
  end

  def replace_collaborators(user_ids)
    collaborations.each {|c| c.destroy unless c.role == 'owner' }
    if user_ids
      user_ids.each do |uid|
        self.collaborations.create user_id: uid, role: 'collaborator'
      end
    end
  end

  def premium_only_privacy
    if private && owner && !owner.account.premium?
      self.private = false
    end
  end
end
