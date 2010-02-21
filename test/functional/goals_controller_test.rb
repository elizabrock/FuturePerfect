require 'test_helper'

class GoalsControllerTest < ActionController::TestCase

  def setup
    @user = Factory.create :user
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
      post :create, :goal => Factory.attributes_for(:goal)
    end
  
    assert_redirected_to goal_path(assigns(:goal))
  end
  
  test "should show goal" do
    @goal = Factory.create(:goal)
    get :show, :id => @goal.to_param
    assert_response :success
  end
  
  test "should get edit" do
    @goal = Factory.create(:goal)
    get :edit, :id => @goal.to_param
    assert_response :success
  end
  
  test "should update goal" do
    @goal = Factory.create(:goal)
    put :update, :id => @goal.to_param, :goal => @goal.attributes
    assert_redirected_to goal_path(assigns(:goal))
  end
  
  test "should destroy goal" do
    @goal = Factory.create(:goal)
    assert_difference('Goal.count', -1) do
      delete :destroy, :id => @goal.to_param
    end
  
    assert_redirected_to goals_path
  end
end
