require 'test_helper'

class GoalTest < ActiveSupport::TestCase
  
  should_allow_values_for :description, "Go to town", "A", "A really long description"
  should_not_allow_values_for :description, "", nil

  should_belong_to :parent_goal
  should_belong_to :user
  should_have_many :child_goals
  
  should_validate_presence_of :user, :message => "can't be blank"
  
  test "should have child goals" do
    @user = Factory.create :user
    5.times do
      goal = Factory.create :goal, :user => @user
      assert_equal @user, goal.user
      5.times do
        Factory.create :child_goal, :user => @user, :parent_goal => goal
      end
    end
    assert_equal 5, @user.top_level_goals.size
    @user.top_level_goals.each do |goal|
      assert_equal 5, goal.child_goals.size
    end
  end
  
  test "should return top level goals for the root_goals named scope" do
    user = Factory.create :user
    roots = []
    leaves = []
    5.times do
      root = Factory.create :goal, :user => user
      roots << root
      5.times do
        child = Factory.create :child_goal, :parent_goal => root, :user => user
        2.times do
          leaf = Factory.create :child_goal, :parent_goal => child, :user => user
          leaves << leaf
        end
      end
    end
    user.reload
    roots_result = user.goals.root_goals
    #leafs_result = @user.goals.leaf_goals
    assert_equal 5, roots_result.size
    assert_equal [], roots_result - roots
    assert_equal [], roots - roots_result
  end
  
  # test "should not be able to update user" do
  #   user1 = Factory.create :user
  #   user2 = Factory.create :user
  #   @goal = Factory.create(:goal, :user => user1)
  #   assert_equal user1, @goal.user
  #   @goal.user = user2
  #   @goal.save
  #   @goal.reload
  #   assert_not_equal user2, @goal.user
  # end
end
