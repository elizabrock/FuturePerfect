class Goal < ActiveRecord::Base
  belongs_to :parent_goal, :class_name => "Goal"
  has_many :child_goals, :class_name => "Goal", :foreign_key => "parent_goal_id"
  
  validates :description, :presence => true
  #validates :completed_at
  #validates :parent_goal
  #validates :user, :presence => true
end
