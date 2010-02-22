class Goal < ActiveRecord::Base
  
  attr_accessible :user, :description, :parent_goal
  
  belongs_to :user
  belongs_to :parent_goal, :class_name => "Goal"
  has_many :child_goals, :class_name => "Goal", :foreign_key => "parent_goal_id"
  
  validates :description, :presence => true
  #validates :completed_at
  #validates :parent_goal
  validates :user, :presence => true
  
  # is_leaf_node? has_child? has_parent? is_root_node? last_progress_made_at is_complete?

end
