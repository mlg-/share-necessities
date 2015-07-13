class User < ActiveRecord::Base
  has_many :organizers
  has_many :organizations, through: :organizers

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
