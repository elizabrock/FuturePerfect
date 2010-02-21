require 'test_helper'

class GoalTest < ActiveSupport::TestCase
  
  should_allow_values_for :description, "Go to town", "A", "A really long description"
  should_not_allow_values_for :description, "", nil

  should_belong_to :parent_goal
  should_have_many :child_goals
end
