require 'test_helper'

class GoalsControllerTest < ActionController::TestCase

  def setup
    @user = Factory.create :user
    @other_user = Factory.create :user
    sign_in @user
  end

  test "a signed out user can't get index" do
    sign_out @user
    get :index
    assert_redirected_to new_user_session_path(:unauthenticated =>'true')
  end

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
      post :create, :goal => Factory.attributes_for(:goal, :user => @user)
    end

    assert_redirected_to goal_path(assigns(:goal))
  end

  test "create goal should ignore conflicting user attribute" do
    assert_difference('Goal.count') do
      post :create, :goal => Factory.attributes_for(:goal, :user => @other_user)
    end
    assert_redirected_to goal_path(assigns(:goal))
    assert_equal assigns(:goal).user, @user
  end

  test "should show user's goal" do
    @goal = Factory.create(:goal, :user => @user)
    get :show, :id => @goal.to_param
    assert_response :success
  end

  test "should not show other user's goal" do
    @goal = Factory.create(:goal, :user => @other_user)
    get :show, :id => @goal.to_param
    assert_redirected_to goals_path
  end

  test "should get edit for own goal" do
    @goal = Factory.create(:goal, :user => @user)
    get :edit, :id => @goal.to_param
    assert_response :success
  end

  test "should not get edit for other's goal" do
    @goal = Factory.create(:goal, :user => @other_user)
    get :edit, :id => @goal.to_param
    assert_redirected_to goals_path
  end

  test "should update own goal" do
    @goal = Factory.create(:goal, :user => @user)
    put :update, :id => @goal.to_param, :goal => @goal.attributes
    assert_redirected_to goal_path(assigns(:goal))
  end

  test "should not update other's goal" do
    @goal = Factory.create(:goal, :user => @other_user)
    put :update, :id => @goal.to_param, :goal => @goal.attributes
    assert_redirected_to goals_path
  end

  test "should destroy own goal" do
    @goal = Factory.create(:goal, :user => @user)
    assert_difference('Goal.count', -1) do
      delete :destroy, :id => @goal.to_param
    end
    assert_redirected_to goals_path
  end

  test "should not destroy other's goal" do
    @goal = Factory.create(:goal, :user => @other_user)
    assert_no_difference('Goal.count') do
      delete :destroy, :id => @goal.to_param
    end

    assert_redirected_to goals_path
  end
end
