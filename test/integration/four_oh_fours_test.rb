require 'test_helper'

class FourOhFoursTest < ActionController::IntegrationTest

  test "should respond with 404 when viewing page that doesn't exist" do
    get 'not/so/perfect/perfect'
    assert_template 'shared/404'
    assert_response :missing
  end

end
