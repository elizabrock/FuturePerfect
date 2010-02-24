ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'rails/test_help'
include Devise::TestHelpers

class ActiveSupport::TestCase

  def create_tree_of_goals_for_user user
    5.times do
      root = Factory.create :goal, :user => user
      5.times do
        child = Factory.create :child_goal, :parent_goal => root, :user => user
        2.times do
          leaf = Factory.create :child_goal, :parent_goal => child, :user => user
        end
      end
    end
  end
  
end
