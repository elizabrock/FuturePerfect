class User < ActiveRecord::Base
  devise :authenticatable, :confirmable, :recoverable, :rememberable, :registerable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation
end
