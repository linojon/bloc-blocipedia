class Wiki < ActiveRecord::Base
  has_many :collaborations
  has_many :collaborators, through: :collaborations, class_name: 'User'

  validates :title, uniqueness: true
end
