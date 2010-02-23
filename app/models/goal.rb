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

  def is_leaf_node?
    
  end
  
  def has_child_goals?
    !child_goals.empty?
  end
  
  def is_root_node?
    @parent_goal == nil
  end
  
  def last_progress_made_at
    #descendant_node with most recent completed_at
  end
  
  def is_complete?
    completed_at != nil
  end
end
