require 'test_helper'

class GoalsControllerTest < ActionController::TestCase

  def setup
    @user = Factory.create :user
    @other_user = Factory.create :user
    sign_in @user
    create_tree_of_goals_for_user @user
    @user.reload
  end

  test "a signed out user can't get index" do
    sign_out @user
    get :index
    assert_redirected_to new_user_session_path(:unauthenticated =>'true')
  end

  test "should get index with list of root goals" do
    get :index
    assert_response :success
    assert_not_nil assigns(:goals)
    assert_equal 5, assigns(:goals).size
  end

  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should get new for child goal" do
    @goal = Factory.create :goal, :user => @user
    get :new, :id => @goal.id
    assert_response :success
    #TODO: Assert contents to prove that the right form was generated
  end
  
  test "should get new for child goal of someone else's goal" do
    @goal = Factory.create :goal, :user => @other_user
    get :new, :id => @goal.id
    assert_response :missing
    assert_template "shared/404"
    #TODO: Assert contents to prove that the right form was generated
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

  test "should create a child goal for my own goal" do
    @goal = Factory.create(:goal, :user => @user)
    assert_difference('Goal.count') do
      post :create, :goal => Factory.attributes_for(:child_goal, :user => @user, :parent_goal => @goal)
    end
    created_goal = assigns(:goal)
    assert_redirected_to goal_path(created_goal)
    assert_equal @goal, created_goal.parent_goal
  end
  
  test "should not create a child goal for someone else's goal" do
    @goal = Factory.create(:goal, :user => @other_user)
    assert_no_difference('Goal.count') do
      post :create, :goal => Factory.build(:child_goal, :user => @user, :parent_goal => @goal)
    end
      assert_response :missing
      assert_template "shared/404"
  end

  test "should show user's goal" do
    @goal = Factory.create(:goal, :user => @user)
    get :show, :id => @goal.to_param
    assert_response :success
  end

  test "showing user's goal should have breadcrumb to create child goal" do
    @goal = Factory.create(:goal, :user => @user)
    get :show, :id => @goal.to_param
    assert_response :success
    assert_select "div#topbar div#rightbutton a[href=?]", new_goal_child_path(@goal)
  end
  
  test "should show user's child goal with breadcrumb to ancestor goals" do
    @goal = Factory.create(:goal, :user =>  @user)
    @goal1 = Factory.create(:child_goal, :user => @user, :parent_goal => @goal)
    @goal2 = Factory.create(:child_goal, :user => @user, :parent_goal => @goal1)
    get :show, :id => @goal2.to_param
    assert_response :success
    assert_equal @goal, @goal2.parent_goal.parent_goal
    assert @goal2.parent_goal.parent_goal.is_root_node?
    assert_select "div#topbar div#leftnav a[href=?]", goal_path(@goal2.parent_goal.parent_goal)
    assert_select "div#topbar div#leftnav a[href=?]", goal_path(@goal2.parent_goal)
  end

  test "should not show other user's goal" do
    @goal = Factory.create(:goal, :user => @other_user)
    get :show, :id => @goal.to_param
    assert_response :missing
    assert_template "shared/404"
  end
  
  test "should not show other user's child goal" do
    @goal = Factory.create(:child_goal, :user => @other_user)
    get :show, :id => @goal.to_param
    assert_response :missing
    assert_template "shared/404"
  end

  test "should get edit for own goal" do
    @goal = Factory.create(:goal, :user => @user)
    get :edit, :id => @goal.to_param
    assert_response :success
  end

  test "should not get edit for other's goal" do
    @goal = Factory.create(:goal, :user => @other_user)
    get :edit, :id => @goal.to_param
    assert_response :missing
    assert_template "shared/404"
  end

  test "should update own goal" do
    @goal = Factory.create(:goal, :user => @user)
    put :update, :id => @goal.to_param, :goal => @goal.attributes
    assert_redirected_to goal_path(assigns(:goal))
  end

  test "should not update other's goal" do
    @goal = Factory.create(:goal, :user => @other_user)
    put :update, :id => @goal.to_param, :goal => @goal.attributes
    assert_response :missing
    assert_template "shared/404"
  end

  test "should destroy own goal" do
    @goal = Factory.create(:goal, :user => @user)
    assert_difference('Goal.count', -1) do
      delete :destroy, :id => @goal.to_param
      assert_redirected_to goals_path
    end
  end

  test "should not destroy other's goal" do
    @goal = Factory.create(:goal, :user => @other_user)
    assert_no_difference('Goal.count') do
      delete :destroy, :id => @goal.to_param
    end
    
    assert_response :missing
    assert_template "shared/404"
  end
end
