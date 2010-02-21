ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'rails/test_help'
include Devise::TestHelpers

class ActiveSupport::TestCase

end
