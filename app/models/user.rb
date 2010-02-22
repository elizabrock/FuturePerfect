class User < ActiveRecord::Base
  has_many :goals
  has_many :top_level_goals, :class_name => "Goal", :conditions => {:parent_goal_id => nil}
  
  devise :authenticatable, :confirmable, :recoverable, :rememberable, :registerable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation
end
