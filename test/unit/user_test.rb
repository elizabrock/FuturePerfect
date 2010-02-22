require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should_have_many :goals

  test "should have many goals" do
    @user = Factory.create :user
    5.times do
      Factory.create :goal, :user => @user
    end
    assert_equal 5, @user.goals.size
  end

  test "should have goals and primary goals" do
    @user = Factory.create :user
    5.times do
      goal = Factory.create :goal, :user => @user
      5.times do
        Factory.create :child_goal, :user => @user, :parent_goal => goal
      end
    end
    assert_equal 30, @user.goals.size
    assert_equal 5, @user.top_level_goals.size
  end
  
end
