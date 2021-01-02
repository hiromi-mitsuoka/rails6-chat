class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable
         
  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true
  
  has_many :messages
end
