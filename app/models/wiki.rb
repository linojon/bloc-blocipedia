class Wiki < ActiveRecord::Base
  has_many :collaborations
  has_many :users, through: :collaborations

  validates :title, uniqueness: true
end
