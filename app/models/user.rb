class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :collaborations
  has_many :wikis, through: :collaborations
  has_one :account

  before_create :build_default_account

  def role_for(wiki)
    collab = collaborations.where(wiki: wiki).first
    collab && collab.role
  end

  def build_default_account
    build_account
  end
end
