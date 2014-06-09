class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :collaborations
  has_many :wikis, through: :collaborations

  def role_for(wiki)
    collab = collaborations.where(wiki: wiki).first
    collab && collab.role
  end
end
