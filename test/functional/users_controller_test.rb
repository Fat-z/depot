require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @input_attributes = {
      name:                  "sam",
      password:              "private",
      password_confirmation: "private"
    }
    @user = users(:one)
  end

  test "should get index" do
    get :index
    if User.find_by_id(session[:user_id]).identity != "administrator"
      assert_redirected_to store_path
    else    
      assert_response :success
      assert_not_nil assigns(:users)
    end
  end

  test "should get new" do
    get :new
    if session[:user_id] == nil or User.find(session[:user_id]).identity == "administrator"
      assert_response :success
    else
      assert_redirected_to store_path
    end
  end

  test "should create user" do
    #assert_difference('User.count') do
      post :create, user: @input_attributes
    #end
    if session[:user_id] != nil or User.find_by_id(session[:user_id]).identity != "administrator"
      assert_redirected_to store_path
    else
      assert_redirected_to store_path
    end
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user

    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: @input_attributes
    assert_redirected_to admin_path
  end

  #test "should destroy user" do
   # assert_difference('User.count', -1) do
    #  delete :destroy, id: @user
    #end

    #assert_redirected_to users_path
  #end
end
