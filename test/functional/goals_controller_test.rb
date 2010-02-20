require 'test_helper'

class GoalsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:goals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create goal" do
    assert_difference('Goal.count') do
      post :create, :goal => goals(:one).attributes
    end

    assert_redirected_to goal_path(assigns(:goal))
  end

  test "should show goal" do
    get :show, :id => goals(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => goals(:one).to_param
    assert_response :success
  end

  test "should update goal" do
    put :update, :id => goals(:one).to_param, :goal => goals(:one).attributes
    assert_redirected_to goal_path(assigns(:goal))
  end

  test "should destroy goal" do
    assert_difference('Goal.count', -1) do
      delete :destroy, :id => goals(:one).to_param
    end

    assert_redirected_to goals_path
  end
end
