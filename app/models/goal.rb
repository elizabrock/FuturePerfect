class Goal < ActiveRecord::Base
  belongs_to :parent_goal, :class_name => "Goal"
end
