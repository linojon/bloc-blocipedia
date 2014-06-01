class Collaboration < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki
  validates :role, inclusion: { in: %w(owner collaborator) }
end
