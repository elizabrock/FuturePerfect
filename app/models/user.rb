class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me

  before_validation(on: :create) do
    self.password_confirmation = self.password if self.password
  end

  has_many :goals
end
