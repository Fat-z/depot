require 'test_helper'

class VisionsControllerTest < ActionController::TestCase
  setup do
    @vision = visions(:one)
    @update = {
      title:       'Ruby',
      publisher:   '1',
      taker:        1,
      number:       2,
      email:        "631979719@qq.com",
      comment:      "hi"
    }    
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:visions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vision" do
    assert_difference('Vision.count') do
      post :create, vision: @update
      #post :create, vision: { publisher: @vision.publisher, taker: @vision.taker, title: @vision.title, number: @vision.number }
    end

    assert_redirected_to vision_path(assigns(:vision))
  end

  test "should show vision" do
    get :show, id: @vision
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vision
    assert_response :success
  end

  test "should update vision" do
    put :update, id: @vision, vision:  @update
    #put :update, id: @vision, vision: { publisher: @vision.publisher, taker: @vision.taker, title: @vision.title, number: @vision.number }
    assert_redirected_to vision_path(assigns(:vision))
  end

  test "should destroy vision" do
    assert_difference('Vision.count', -1) do
      delete :destroy, id: @vision
    end

    assert_redirected_to visions_path
  end
end
