class Wiki < ActiveRecord::Base
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :user

  validates :title, uniqueness: true

  extend FriendlyId
  friendly_id :title, use: :slugged

end
