class User < ActiveRecord::Base
  has_many :organizers
  has_many :organizations, through: :organizers
  has_many :items

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def self.is_organizer?(user)
    return true unless Organizer.where(user_id: user.id).empty?
  end
end
