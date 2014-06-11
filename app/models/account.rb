class Account < ActiveRecord::Base
  validates :level, inclusion: { in: %w(free premium) }
  belongs_to :user

  def premium?
    level == 'premium'
  end
end
