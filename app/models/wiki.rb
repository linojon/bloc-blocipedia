class Wiki < ActiveRecord::Base
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :user

  validates :title, uniqueness: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  scope :not_private, -> { where(private: false) }
  scope :is_private,  -> { where(private: true) }

  def replace_collaborators(user_ids)
    collaborations.each {|c| c.destroy unless c.role == 'owner' }
    if user_ids
      user_ids.each do |uid|
        self.collaborations.create user_id: uid, role: 'collaborator'
      end
    end
  end

end
